import { Box, Text, Group, Tooltip } from "@mantine/core"
import {CryptoTypes} from '../../../types/types'
import classes from './accountsStyle.module.css'

interface HeaderProps {
  cryptos: CryptoTypes[];
}

export const Accounts = ({cryptos}:HeaderProps) => {
  return (
    <Box className={classes.cryptos}>
        {cryptos.slice(0,4).map((crypto) => (
            <Tooltip label={crypto.label} color="dark.4" position="bottom">
              <Group key={crypto.name} className={classes.account} fz="xs" gap="xs">
                <i className={crypto.icon} />
                <Text fz="xs">{(crypto.amount).toLocaleString("en-US")}</Text>
              </Group>
            </Tooltip>
        ))}
    </Box>
  )
}
