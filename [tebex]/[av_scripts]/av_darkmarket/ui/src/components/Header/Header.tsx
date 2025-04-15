import { Group } from "@mantine/core";
import { CryptoTypes, TabType } from "../../types/types";
import classes from "./headerStyle.module.css";
import { Tabs } from "./Tabs/Tabs";
import { Accounts } from "./Accounts/Accounts";

interface HeaderProps {
  cryptos: CryptoTypes[];
  tabs: TabType[];
  showCart: (state: boolean) => void;
  active: string;
  setActive: (option: string) => void;
}

export const Header = ({
  cryptos,
  tabs,
  showCart,
  active,
  setActive,
}: HeaderProps) => {
  return (
    <Group className={classes.container}>
      <Tabs
        tabs={tabs}
        showCart={showCart}
        active={active}
        setActive={setActive}
      />
      <Accounts cryptos={cryptos} />
    </Group>
  );
};
