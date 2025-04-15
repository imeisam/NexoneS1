import {
  Box,
  Grid,
  Card,
  Image,
  Text,
  Group,
  Flex,
  Button,
  Tooltip,
} from "@mantine/core";
import { IconX } from "@tabler/icons-react";
import { Product } from "../../types/types";
import classes from "./style.module.css";
import { useState } from "react";
import { fetchNui } from "../../hooks/useNuiEvents";
import { useRecoilValue } from "recoil";
import { identifier, isAdmin, Lang } from "../../reducers/atoms";

interface Properties {
  items: Product[];
  handleDelete: (identifier: string) => void;
}

export const Content = ({ items, handleDelete }: Properties) => {
  const lang: any = useRecoilValue(Lang);
  const [hovered, setHovered] = useState(9999);
  const admin = useRecoilValue(isAdmin);
  const cid = useRecoilValue(identifier);
  const handleContact = (phone: string) => {
    fetchNui("av_marketplace", "copy", phone);
  };
  return (
    <Grid p="md" className={classes.container}>
      {items.map((product, index: number) => (
        <Grid.Col span={2} miw={255}>
          <Card withBorder radius="sm" className={classes.card}>
            <Card.Section
              onMouseEnter={() => {
                setHovered(index);
              }}
              onMouseLeave={() => {
                setHovered(9999);
              }}
            >
              {admin || cid == product.owner ? (
                <Box className={classes.delete}>
                  <Tooltip label={lang.deleteAd} fz="xs" color="dark.4">
                    <IconX
                      style={{
                        width: "14px",
                        height: "14px",
                        color: "white",
                      }}
                      onClick={() => {
                        handleDelete(product.identifier);
                      }}
                    />
                  </Tooltip>
                </Box>
              ) : null}

              <Box
                className={classes.hover}
                style={{ display: hovered == index ? "none" : "block" }}
              >
                <Text>{lang.hover}</Text>
              </Box>
              <Image
                src={product.image}
                height={135}
                fallbackSrc="https://www.womantowomanmentoring.org/wp-content/uploads/placeholder.jpg"
                style={{
                  filter: hovered == index ? "blur(0px)" : "blur(2.55px)",
                  transition: "opacity 100ms ease",
                }}
              />
            </Card.Section>
            <Text className={classes.title} fw={500} mt="xs" c="white" truncate>
              {product.title}
            </Text>
            <Text
              fz="xs"
              c="dimmed"
              lineClamp={4}
              mt={4}
              h={65}
              style={{ overflow: "auto" }}
            >
              {product.description}
            </Text>
            <Group justify="space-between" className={classes.footer}>
              <Flex direction="column">
                <Text fz="xs" c="gray.5" fw={500}>
                  {lang.price}
                </Text>
                <Text
                  fz="xs"
                  c="white"
                  fw={600}
                >{`$${product.price.toLocaleString("en-US")}`}</Text>
              </Flex>
              <Button
                size="xs"
                color="#6271eb"
                onClick={() => {
                  handleContact(product.phone);
                }}
              >
                {lang.contactButton}
              </Button>
            </Group>
          </Card>
        </Grid.Col>
      ))}
    </Grid>
  );
};
