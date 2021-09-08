import React from 'react'
import { Modal } from 'react-bootstrap'
import { IconClose, IconMetaMask } from '../../assets/icons'
import { Button } from 'react-bootstrap'
import styles from './ConnectWallet.module.scss'

const ModalConnectWallet = (props) => {
  const { showModal, onClose } = props

  return (
    <Modal centered show={showModal} onHide={onClose}>
      <Modal.Header>
        <Modal.Title>Connect Wallet</Modal.Title>
        <Button variant="light" onClick={onClose}>
          <IconClose />
        </Button>
      </Modal.Header>

      <Modal.Body>
        <div className={styles.walletList}>
          <ul>
            <li>
              <Button variant="secondary">
                <span>MetaMask</span>
                <IconMetaMask />
              </Button>
            </li>
          </ul>
        </div>
      </Modal.Body>
    </Modal>
  )
}

export default ModalConnectWallet
