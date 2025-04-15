import {
  Box,
  Group,
  Select,
  TextInput,
  Button,
  Image,
  Text,
} from "@mantine/core";
import { IconSearch } from "@tabler/icons-react";
import classes from "./style.module.css";
import { useRecoilValue } from "recoil";
import { Lang } from "../../reducers/atoms";

interface options {
  value: string;
  label: string;
}

interface Properties {
  categories: options[];
  category: string;
  handleCategory: (option: string | null) => void;
  handleSearch: (value: string) => void;
  handleAd: () => void;
  canCreate: boolean;
}

export const Header = ({
  categories,
  category,
  handleCategory,
  handleSearch,
  handleAd,
  canCreate,
}: Properties) => {
  const lang: any = useRecoilValue(Lang);
  return (
    <Box className={classes.header}>
      <Group p="xs" justify="space-between" w="100%">
        <Group gap="xs">
          <Image src="./icon.png" w={40} h={40} mt={3} />
          <Text fw={500} fz="xl">
            {lang.header}
          </Text>
        </Group>
        <Group gap={"xs"}>
          <TextInput
            classNames={classes}
            size="xs"
            placeholder={lang.search}
            onChange={(e) => {
              handleSearch(e.target.value);
            }}
            leftSection={
              <IconSearch
                style={{
                  width: "12px",
                  height: "12px",
                }}
              />
            }
          />
          <Select
            classNames={classes}
            data={categories}
            placeholder="Categories"
            value={category}
            onChange={(e) => {
              handleCategory(e);
            }}
            allowDeselect={false}
            size="xs"
          />
          {canCreate && (
            <Button size="xs" color="#6271eb" onClick={handleAd}>
              {lang.createAd}
            </Button>
          )}
        </Group>
      </Group>
    </Box>
  );
};
