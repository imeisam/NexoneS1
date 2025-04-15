import { CartType, AccountsType } from "../types/types";

export const getAccountSummary = (cart: CartType[]): AccountsType[] => {
  const summary = cart.reduce((acc, item) => {
    const totalItemPrice = item.price * item.amount;
    if (!acc[item.account]) {
      acc[item.account] = { account: item.account, accountLabel: item.accountLabel, totalPrice: 0 };
    }
    acc[item.account].totalPrice += totalItemPrice;
    return acc;
  }, {} as Record<string, AccountsType>);

  return Object.values(summary);
};