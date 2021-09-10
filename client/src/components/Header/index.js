import React from 'react'
import styles from './header.module.scss'
import getWeb3, { getGanacheWeb3, Web3 } from '../../utils/getWeb3'
import { Logo } from '../../assets/images'

const Header = (props) => {
  const { web3, accounts, showModalSelectWallet } = props

  return (
    <div className={styles.header}>
      <nav id="menu" className="menu">
        <ul>
          {/* <li><a href="/" className={styles.link}><span style={{ padding: "60px" }}>Home</span></a></li> */}
          <li>
            <a href="/" className={styles.link}>
              <img src={Logo}></img>
            </a>
          </li>

          {/* <li>
            <a href="/publish" className={styles.link}>
              {' '}
              Publish
            </a>
          </li> */}

          <li>
            <a href="/my-photos" className={styles.link}>
              {' '}
              My Photos
            </a>
          </li>

          {process.env.NODE_ENV !== 'photo_marketplace' && (
            <li>
              <a href="/photo-marketplace" className={styles.link}>
                {' '}
                PhotoMarketPlace
              </a>
            </li>
          )}
        </ul>
      </nav>
      {/* <div className={styles.connectWallet}>
        {web3 && accounts && accounts.length ? (
          <span>accounts[0]</span>
        ) : (
          <a className={styles.link} onClick={showModalSelectWallet}>
            Connect Wallet
          </a>
        )}
      </div> */}
    </div>
  )
}

export default Header
