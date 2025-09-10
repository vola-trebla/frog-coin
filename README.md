# 🐸 FrogCoin

<img width="1024" height="1024" alt="image" src="https://github.com/user-attachments/assets/3a3a3c99-697f-429d-80e4-daaaa28b618c" />


ERC20 smart contract with mint & burn functionality and full Foundry unit tests.  
Built with Solidity ^0.8.0 and OpenZeppelin.

---

## 📄 Smart Contract

File: `src/FrogCoin.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FrogCoin is ERC20, Ownable {
    constructor() ERC20("FrogCoin", "FROG") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyOwner {
        _burn(from, amount);
    }
}
```

---

## ✅ Features
- ERC20 standard based on OpenZeppelin
- `mint`: only owner can mint tokens
- `burn`: only owner can burn tokens from any address
- Access control via `Ownable`

---

## 🧪 Tests

File: `test/FrogCoin.t.sol`

- `test_InitialSupplyAndDetails` → verifies name, symbol, decimals, totalSupply
- `test_Mint_Success` → owner can mint tokens
- `test_Mint_RevertWhenNotOwner` → non-owner cannot mint
- `test_Burn_Success` → burn tokens successfully
- `test_Burn_RevertWhenNotOwner` → revert if non-owner tries to burn
- `test_Burn_RevertInsufficientBalance` → revert if trying to burn too much
- `test_Transfer_Success` → standard ERC20 transfer works

---

## 🚀 How to Run

Make sure you have Foundry installed.

```bash
# Initialize project
forge init frog-coin

# Install dependencies
forge install OpenZeppelin/openzeppelin-contracts@v4.9.3

# Run tests
forge test
```

---

## 📜 License

MIT
