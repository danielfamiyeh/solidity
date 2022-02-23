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
      address[] memory addressBook = _addresses[msg.sender];

      for(uint i=0; i < addressBook.length; i++) {
          if(addressBook[i] == addr) {
              _addresses[msg.sender].push(addr);
              _aliases[msg.sender][addr] = _alias;
          }

          else {
              _addresses[msg.sender].push(addr);
              _aliases[msg.sender][addr] = _alias;
          }
      }
  }

  function removeByAddress(address addr) public {
      uint bookLength = _addresses[msg.sender].length;

      for (uint i=0; i<bookLength; i++) {
          if(i < bookLength-1 && bookLength > 1 && _addresses[msg.sender][i] == addr){
              _addresses[msg.sender][i] = _addresses[msg.sender][bookLength-1];
          }

          delete _addresses[msg.sender][bookLength-1];
          delete _aliases[msg.sender][addr];
      }
  }

  function getAddressBookLength(address addr) public view returns(uint) {
      return _addresses[addr].length;
  }
}