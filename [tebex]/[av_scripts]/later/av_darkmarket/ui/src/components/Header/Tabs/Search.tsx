import { TextInput, rem } from "@mantine/core";
import { IconSearch } from "@tabler/icons-react";
import { useRecoilValue, useSetRecoilState } from "recoil";
import { Products, AllProducts, Lang } from "../../../reducers/atoms";
import classes from "./searchStyle.module.css";

interface Properties {
  active: string | null;
}

export const Search = ({ active }: Properties) => {
  const allProducts = useRecoilValue(AllProducts);
  const lang: any = useRecoilValue(Lang);
  const setProducts = useSetRecoilState(Products);
  const handleSearch = (input: string) => {
    const trimmedInput = input.trim().toLowerCase();
    if (trimmedInput.length === 0) {
      if (active == "all") {
        setProducts(allProducts);
      } else {
        const filtered = allProducts.filter(
          (product) => product.category === active
        );
        setProducts(filtered);
        return;
      }
    }
    const res = allProducts.filter((product) =>
      product.label.toLowerCase().includes(trimmedInput)
    );
    setProducts(res);
  };
  const icon = <IconSearch style={{ width: rem(16), height: rem(16) }} />;
  return (
    <TextInput
      ml={"xs"}
      classNames={classes}
      rightSectionPointerEvents="none"
      rightSection={icon}
      placeholder={lang.search}
      onChange={(e) => {
        handleSearch(e.target.value);
      }}
      size="xs"
    />
  );
};
