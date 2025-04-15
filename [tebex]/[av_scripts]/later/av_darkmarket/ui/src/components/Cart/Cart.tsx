import { Box, Image, Text, Stack, Group, NumberInput, ActionIcon, Button } from "@mantine/core"
import { useRecoilState, useRecoilValue } from "recoil"
import { CartItems, AccountList, AllProducts, Inventory, Lang} from "../../reducers/atoms"
import { IconTrash } from '@tabler/icons-react'
import classes from './cartStyle.module.css'
import { CartType, ItemType } from "../../types/types"
import { getAccountSummary } from "../../hooks/getAccounts"
import { fetchNui } from "../../hooks/useNuiEvents"

const updateCartAmount = (cart: CartType[], product: ItemType, amount: number): CartType[] => {
  return cart.map(item => {
    if (item.name === product.name) {
      return { ...item, amount: amount }
    }
    return item
  })
}

export const Cart = () => {
  const [cart, setCart] = useRecoilState(CartItems)
  const [accounts, setAccounts] = useRecoilState(AccountList)
  const [allProducts, setAllProducts] = useRecoilState(AllProducts)
  const inventory = useRecoilValue(Inventory)
  const lang:any = useRecoilValue(Lang)
  const handleAmount = (amount: number, product: ItemType) => {
    const allProduct = allProducts.find((item) => item.name === product.name)
    if (!allProduct) return
    const currentCartProduct = cart.find((item) => item.name === product.name)
    if (!currentCartProduct) return
    const currentAmount = currentCartProduct.amount
    const difference = amount - currentAmount
    if (difference > 0) {
        if (allProduct.stock >= difference) {
            const newCart = updateCartAmount(cart, product, amount)
            setCart(newCart)
            const updatedProducts = allProducts.map((item) => {
                if (item.name === product.name) {
                return { ...item, stock: item.stock - difference }
                }
                return item
            })
            setAllProducts(updatedProducts)     
            const updated = getAccountSummary(newCart)
            setAccounts(updated)
        }
    } else if (difference < 0) {
        const newCart = updateCartAmount(cart, product, amount)
        setCart(newCart)
        const updatedProducts = allProducts.map((item) => {
        if (item.name === product.name) {
            return { ...item, stock: item.stock - difference }
        }
        return item
        })
        setAllProducts(updatedProducts)
        const updated = getAccountSummary(newCart)
        setAccounts(updated)
    }}
    const handleDelete = (product: CartType) => {
        const name = product.name
        const newCart = cart.filter((item) => item.name !== name)
        setCart(newCart)
        const updated = getAccountSummary(newCart)
        setAccounts(updated)
        const updatedProducts = allProducts.map((item) => {
        if (item.name === name) {
            return { ...item, stock: item.stock + product.amount }
        }
            return item
        })
        setAllProducts(updatedProducts)
    }
    const handleClear = () => {
        const updatedProducts = allProducts.map((product) => {
            const cartItem = cart.find((item) => item.name === product.name)
            if (cartItem) {
            return { ...product, stock: product.stock + cartItem.amount }
            }
            return product
        })
        setAllProducts(updatedProducts)
        setAccounts([])
        setCart([])
    }
    const handlePay = async() => {
        const resp = await fetchNui("av_darkmarket", "buy", cart)
        if(resp) {
            setAccounts([])
            setCart([])
        }
    }
  return (
    <Box className={classes.container}>
        {cart[0] &&
            <Box className={classes.box}>
                <Stack className={classes.productList} gap="xs">
                    {cart.map((product:any) => (
                        <Box className={classes.card} p={"sm"}>
                            <Group className={classes.content} justify="space-between" w={"100%"} grow gap="xl">
                                <Image src={`https://cfx-nui-${inventory}${product.name}.png`} className={classes.image} fallbackSrc='https://r2.fivemanage.com/QmVAYSlqeAlD4IxVbdvu5/test2.png'/>
                                <Text size='sm' fw={600} >{product.label}</Text>
                                <Text size='sm'>{`${product.price * product.amount} ${product.accountLabel}`}</Text>
                                <NumberInput size="xs" w={50} value={product.amount} onChange={(e) => {handleAmount(Number(e), product)}} allowDecimal={false} allowLeadingZeros={false} allowNegative={false} min={1} max={product.stock}/>
                                <ActionIcon size="xs" maw={25} variant="transparent" color="red" onClick={()=>{handleDelete(product)}}>
                                    <IconTrash style={{width: "15px", height: "15px"}} stroke={1.5}/>
                                </ActionIcon>
                            </Group>
                        </Box>
                    ))}
                </Stack>
                <Box className={classes.cartList}>
                    <Group grow bg="radial-gradient(circle, rgba(129, 131, 138, 0.35) 0%, rgba(63, 65, 74, 0.45) 90%)" style={{borderRadius: "4px"}} mb="sm">
                        <Text fw={500}>Account</Text>
                        <Text fw={500}>Total</Text>
                    </Group>
                    {accounts.map((account) => (
                        <Group grow>
                            <Text>{account.accountLabel}</Text>
                            <Text>{account.totalPrice}</Text>
                        </Group>
                    ))}
                    <Group grow className={classes.buttons}>
                        <Button variant='light' color='teal' onClick={handlePay}>{lang.pay}</Button>
                        <Button variant='light' color='red' onClick={handleClear}>{lang.clear}</Button>
                    </Group>
                </Box>
            </Box>
        }
    </Box>
  )
}
