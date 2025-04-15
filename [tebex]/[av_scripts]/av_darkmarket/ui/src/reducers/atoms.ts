import { atom } from 'recoil'
import { CartType, ItemType, AccountsType } from "../types/types";

export const Lang = atom<Object>({
  key: "lang",
  default: {
  },
});

export const CartItems = atom<CartType[]>({
  key: "cart", 
  default: [

  ]
})

export const AllProducts = atom<ItemType[]>({
  key: "allProducts",
  default: [
    {name: "milkshake1", image: "https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/milkshake.png", label: "Chocolate Milkshake", account: "gne", accountLabel: "GNE", price: 25, stock: 2, category: "weapons"},
    {name: "milkshake2", image: "https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/milkshake.png", label: "Chocolate Milkshake", account: "cosmo", accountLabel: "Cosmo", price: 25, stock: 4, category: "weapons"},
  ]
})

export const Products = atom<ItemType[]>({
  key: "products",
  default: [
    {name: "milkshake1", image: "https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/milkshake.png", label: "Chocolate Milkshake", account: "gne", accountLabel: "GNE", price: 25, stock: 2, category: "weapons"},
    {name: "milkshake2", image: "https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/milkshake.png", label: "Chocolate Milkshake", account: "cosmo", accountLabel: "Cosmo", price: 25, stock: 4, category: "weapons"},
  ]
})

export const AccountList = atom<AccountsType[]>({
  key: "accounts",
  default: [
  ]
})

export const Inventory = atom<string>({
  key: "inventory",
  default: ''
})