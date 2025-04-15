export interface CartType {
    name: string,
    label: string,
    price: number,
    amount: number,
    account: string,
    accountLabel: string;
}

export interface CryptoTypes {
    name: string,
    label: string,
    amount: number,
    icon: string
}

export interface ItemType {
  name: string;
  image: string;
  label: string;
  account: string;
  accountLabel: string;
  price: number;
  stock: number;
  category: string;
}

export interface TabType {
  type: string;
  label: string;
  icon: string;
}

export interface AccountsType {
  account: string;
  accountLabel: string;
  totalPrice: number;
}