import { useEffect, useState } from "react";
import { Box, Group, Tooltip, Select } from "@mantine/core";
import { TabType } from "../../../types/types";
import classes from "./tabStyle.module.css";
import { Search } from "./Search";
import { useRecoilValue, useSetRecoilState } from "recoil";
import { Products, AllProducts, Lang } from "../../../reducers/atoms";

interface HeaderProps {
  showCart: (state: boolean) => void;
  tabs: TabType[];
  active: string;
  setActive: (option: string) => void;
}

export const Tabs = ({ showCart, tabs, active, setActive }: HeaderProps) => {
  const allProducts = useRecoilValue(AllProducts);
  const lang: any = useRecoilValue(Lang);
  const setProducts = useSetRecoilState(Products);
  const [options, setOptions] = useState([{ value: "all", label: "All" }]);
  const handleClick = (type: string | null) => {
    if (!type) {
      return;
    }
    setActive(type);
    if (type == "cart") {
      showCart(true);
      return;
    }
    showCart(false);
    if (type == "all") {
      setProducts(allProducts);
    } else {
      const filtered = allProducts.filter(
        (product) => product.category === type
      );
      setProducts(filtered);
    }
  };
  useEffect(() => {
    if (tabs.length > 0) {
      setActive(tabs[0].type);
      const filtered = tabs.map((tab) => ({
        value: tab.type,
        label: tab.label,
      }));
      setOptions(filtered);
    } else {
      setActive("all");
    }
  }, [tabs]);

  return (
    <Box display={"flex"}>
      <Search active={active} />
      <Group ml="sm" gap="xs">
        <Select
          classNames={classes}
          value={active}
          size="xs"
          data={options}
          onChange={(e) => {
            handleClick(e);
          }}
          allowDeselect={false}
        />
        <Tooltip label={lang.all_items} color="dark.4" fz="xs">
          <Box
            className={active == "all" ? classes.activeTab : classes.tab}
            onClick={() => {
              handleClick("all");
            }}
          >
            <i className="fa-solid fa-border-all" />
          </Box>
        </Tooltip>
        <Tooltip label={lang.cart} color="dark.4" fz="xs">
          <Box
            className={active == "cart" ? classes.activeTab : classes.tab}
            onClick={() => {
              handleClick("cart");
            }}
          >
            <i className="fa-solid fa-cart-shopping" />
          </Box>
        </Tooltip>
      </Group>
    </Box>
  );
};
