import { useState, useEffect } from "react"
import { Box } from '@mantine/core'
import { fetchNui, isEnvBrowser, useNuiEvent } from "../hooks/useNuiEvents"
import { CryptoTypes, TabType, ItemType } from "../types/types"
import { Loading } from "./Loading"
import { Header } from "./Header/Header"
import { Content } from "./Content/Content"
import { useSetRecoilState } from "recoil"
import { AllProducts, Products, Inventory } from "../reducers/atoms"
import './appstyle.css'

export const MainApp = () => {
  const setAllProducts = useSetRecoilState(AllProducts)
  const setProducts = useSetRecoilState(Products)
  const setInventory = useSetRecoilState(Inventory)
  const [active, setActive] = useState("")
  const [loaded, setLoaded] = useState(isEnvBrowser())
  const [showCart, setShowCart] = useState(false)
  const [tabs, setTabs] = useState<TabType[]>([])
  const [cryptos, setCryptos] = useState<CryptoTypes[]>([])

  useNuiEvent("updateCryptos", (data:CryptoTypes[]) => {
    setCryptos(data)
  })
  
  useEffect(() => {
    const fetchData = async () => {
      const resp = await fetchNui("av_darkmarket", "getData")
      if(resp) {
        setAllProducts(resp.products)
        setTabs(resp.tabs)
        setInventory(resp.inventory)
        setCryptos(resp.accounts)
        if(resp.tabs[0]) {
          const filtered = resp.products.filter((product:ItemType) => product.category === resp.tabs[0].type)
          setProducts(filtered)
        } else {
          setProducts(resp.products)
        }
      }
      setTimeout(() => {
        setLoaded(true)
      }, 100)
    }
    fetchData()
  }, [])
  
  return (
    <Box className="app" p={"sm"} >
      {loaded ?
        <Box className="app-container">
          <Header active={active} setActive={setActive} cryptos={cryptos} tabs={tabs} showCart={setShowCart}/>
          <Content showCart={showCart} active={active}/>
        </Box>
      :
        <Loading/>
      }
    </Box>
  )
}