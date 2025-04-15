import { atom } from "recoil";
export const Lang = atom<Object>({
  key: "lang",
  default: {},
});

export const isAdmin = atom<boolean>({
  key: "admin",
  default: false,
});

export const identifier = atom<string>({
  key: "identifier",
  default: "Avilchiis",
});
