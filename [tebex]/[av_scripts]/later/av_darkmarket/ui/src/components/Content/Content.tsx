import { useState } from 'react'
import { Grid, Image, Box, Text, Button, Group } from '@mantine/core';
import { IconPackage } from '@tabler/icons-react';
import classes from './contentStyle.module.css'
import { Cart } from '../Cart/Cart';
import { useRecoilState, useRecoilValue } from 'recoil';
import { Products, CartItems, AccountList, AllProducts, Inventory, Lang } from '../../reducers/atoms';
import { getAccountSummary } from "../../hooks/getAccounts";
import { CartType, ItemType } from "../../types/types";

interface Properties {
    showCart: boolean;
    active: string;
}

export const Content = ({showCart, active}:Properties) => {
  const [cart, setCart] = useRecoilState(CartItems)
  const [allProducts, setAllProducts] = useRecoilState(AllProducts)
  const [items, setItems] = useRecoilState(Products)
  const [_, setAccounts] = useRecoilState(AccountList)
  const inventory = useRecoilValue(Inventory)
  const lang:any = useRecoilValue(Lang)
  const [total, setTotal] = useState(0)
  const addToCart = (product: CartType) => {
    const productName = product.name;
    const exist = cart.find((x) => x.name === productName);
    if (exist) {
      const newState = cart.map((obj) => {
        if (obj.name === productName) {
          const newAmount = obj.amount + 1;
          setTotal(total + product.price);
          return { ...obj, amount: newAmount };
        }
        return obj;
      });
      setCart(newState);
      const accounts = getAccountSummary(newState);
      setAccounts(accounts);
    } else {
        const newProduct = { ...product, amount: 1 };
        const newState = [...cart, newProduct];
        setCart(newState);
        const accounts = getAccountSummary(newState);
        setAccounts(accounts);
      }
      const updatedProducts = allProducts.map((item) => {
        if (item.name === productName) {
          return { ...item, stock: item.stock - 1 };
        }
        return item;
      });
      if (active !== "all") {
        const filtered = updatedProducts.filter((product:ItemType) => product.category === active)
        setItems(filtered);  
      } else {
        setItems(updatedProducts); 
      }
      setAllProducts(updatedProducts);
  };
  return <Box className={classes.container}>
    {showCart ? 
        <Cart />
    :
        <Grid mt="xs" >
            {items.map((product:any) => (
                <Grid.Col key={product.name} span={"auto"} maw={210}>
                    <Box className={classes.card}>
                        <Box className={classes.content}>
                            <Image src={`https://cfx-nui-${inventory}${product.name}.png`} className={classes.image} fallbackSrc='https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/test2.png'/>
                            <Box className={classes.name}>
                                <Text size='sm' fw={600} truncate>{product.label}</Text>
                            </Box>
                            <Text size='sm'>{`${product.price} ${product.accountLabel}`}</Text>
                            <Group gap="xs">
                                <IconPackage stroke={1.5} style={{width: "14px", height: "14px"}}/>
                                <Text size='xs'>{product.stock}</Text>
                            </Group>
                            <Button mt="md" size="xs" color="teal" variant='subtle' disabled={product.stock <= 0} onClick={()=>{addToCart(product)}}>{lang.add_cart}</Button>
                        </Box>
                    </Box>
                </Grid.Col>
            ))}
        </Grid>
    }
  </Box>
}
