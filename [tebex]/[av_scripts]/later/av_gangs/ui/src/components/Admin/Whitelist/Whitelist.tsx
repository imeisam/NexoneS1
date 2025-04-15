import { useEffect, useState } from "react";
import {
  Box,
  Group,
  Grid,
  Text,
  Image,
  ActionIcon,
  TextInput,
} from "@mantine/core";
import { fetchNui } from "../../../hooks/useNuiEvents";
import { checkIfImageExists } from "../../../hooks/imageExists";
import { useRecoilValue } from "recoil";
import { Lang } from "../../../reducers/atoms";
import { IconBackspace, IconCopy } from "@tabler/icons-react";
import classes from "./style.module.css";

export const Whitelist = () => {
  const [loading, setLoading] = useState(false);
  const [image, setImage] = useState<string | null>(null);
  const [allImages, setAllImages] = useState<string[]>([]);
  const [showError, setShowError] = useState<string | boolean>(false);
  const lang: any = useRecoilValue(Lang);

  const handleNew = async (value: string) => {
    const isValid = await checkIfImageExists(value);
    if (isValid) {
      const exists = allImages.includes(value);
      if (exists) {
        setShowError(lang.admin.whitelisted);
        setTimeout(() => {
          setShowError(false);
        }, 2000);
        return;
      }
      const copy = [...allImages, value];
      setAllImages(copy);
      fetchNui("av_gangs", "setWhitelist", copy);
    } else {
      setShowError(lang.admin.notValid);
      setTimeout(() => {
        setShowError(false);
      }, 2000);
    }
  };
  const handleCopy = (value: string) => {
    fetchNui("av_laptop", "copy", value);
  };
  const handleRemove = (value: string) => {
    const copy = allImages.filter((image) => image !== value);
    setAllImages(copy);
    fetchNui("av_gangs", "setWhitelist", copy);
  };
  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_gangs", "getWhitelist");
      if (resp) setAllImages(resp);
    };
    fetchData();
  }, []);

  return (
    <Grid className={classes.members} justify="center">
      <Grid.Col span={6}>
        <Box display="block" style={{ overflowY: "hidden" }}>
          <Text fz="xs" c="dimmed" fw={500}>
            {lang.admin.imageSize}
          </Text>
          <TextInput
            classNames={classes}
            placeholder={lang.admin.whitelist}
            mt="xs"
            size="xs"
            onKeyDown={(e) => {
              const value = e.key;
              if (value == "Enter") {
                handleNew(e.currentTarget.value);
                e.currentTarget.value = "";
              }
            }}
            error={showError ? <>{showError}</> : null}
          />
          <Box mt="sm" h={"calc(27vh)"}>
            {allImages.map((url: string, index: number) => (
              <Group
                bg={index % 2 == 1 ? `` : `rgba(60,60,60,0.8)`}
                p={4}
                style={{ borderRadius: "4px", overflowY: "hidden" }}
                grow
              >
                <Text
                  truncate
                  fz="sm"
                  fw={500}
                  c={image == url ? `teal` : `gray.4`}
                  onClick={() => {
                    setLoading(true);
                    setImage(url);
                    setTimeout(() => {
                      setLoading(false);
                    }, 100);
                  }}
                >
                  {url}
                </Text>
                <Group justify="end" ml="auto" mr="sm">
                  <ActionIcon
                    variant="subtle"
                    color="blue"
                    size="sm"
                    maw={60}
                    onClick={() => {
                      handleCopy(url);
                    }}
                  >
                    <IconCopy style={{ width: 15, height: 15 }} />
                  </ActionIcon>
                  <ActionIcon
                    variant="subtle"
                    color="red"
                    size="sm"
                    maw={60}
                    onClick={() => {
                      handleRemove(url);
                    }}
                  >
                    <IconBackspace style={{ width: 15, height: 15 }} />
                  </ActionIcon>
                </Group>
              </Group>
            ))}
          </Box>
        </Box>
      </Grid.Col>
      <Grid.Col span={"auto"} style={{ display: "relative" }}>
        {!loading && image && <Image mt="md" src={image} fit="contain" />}
      </Grid.Col>
    </Grid>
  );
};
