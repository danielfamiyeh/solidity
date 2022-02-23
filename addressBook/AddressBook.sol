// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract AddressBook {
  mapping (address => address[]) private _addresses;
  mapping (address => mapping(address => string)) private _aliases;

  function getAddressBook(address addr) public view returns(address[] memory) {
      return _addresses[addr];
  }

  function addAddress(address addrToAdd, string memory alia) public {
      _addresses[msg.sender].push(addrToAdd);
      _aliases[msg.sender][addrToAdd] = alia;
  }

  function getAlias(address addr) public view returns (string memory) {
      
      string memory _defaultAlias = '';
    if (bytes(_aliases[msg.sender][addr]).length != 0){
      return _aliases[msg.sender][addr];
      }

      return _defaultAlias;
    }

  function updateByAddress(string memory _alias, address addr) public {
      _aliases[msg.sender][addr] = _alias;
  }

  function updateByAlias(string memory _alias, address addr) public {
      bool aliasFound = false;
      address[] memory addressBook = _addresses[msg.sender];

      for(uint i=0; i < addressBook.length; i++) {
          if(addressBook[i] == addr) {
              aliasFound = true;
              _addresses[msg.sender].push(addr);
              _aliases[msg.sender][addr] = _alias;
          }

          else {
              aliasFound = true;
              _addresses[msg.sender].push(addr);
              _aliases[msg.sender][addr] = _alias;
          }
      }
  }
}