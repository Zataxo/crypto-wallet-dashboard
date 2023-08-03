// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract CryptoWallet {
    uint public totalUsers;
    uint public totalTransactions;

    constructor() {
        totalUsers = 0;
        totalTransactions = 0;
        usersMap[totalUsers] = User({
            accountID: totalUsers,
            userAddress: msg.sender,
            userName: "Hassan Ismat",
            userBio: "Software engineer",
            userPass: "123456",
            visaCard: "374245455400126",
            userCurrencies: ["btc", "eth", "ltc", "sol", "bnb"],
            userAmount: [uint(0), uint(0), uint(0), uint(0), uint(0)],
            userID: generateUserID("Hassan Ismat", "123456")
        });
        totalUsers++;
        usersMap[totalUsers] = User({
            accountID: totalUsers,
            userAddress: msg.sender,
            userName: "Ahmed Yassin",
            userBio: "Software engineer",
            userPass: "123456",
            visaCard: "564355455400126",
            userCurrencies: ["btc", "eth", "ltc", "sol", "bnb"],
            userAmount: [uint(0), uint(0), uint(0), uint(0), uint(0)],
            userID: generateUserID("Ahmed Yassin", "123456")
        });
        totalUsers++;
    }

    struct Transaction {
        uint senderID; // PK
        uint receiverID;
        uint amountTransfered;
        string currencyTransfered;
        string tType;
    }
    struct User {
        uint accountID;
        address userAddress;
        string userName;
        string userBio;
        string userPass;
        string visaCard;
        string[5] userCurrencies;
        uint[5] userAmount;
        bytes userID;
    }

    event UserCreated(string userName, uint accountID);
    event UserLogin(string message, uint accountID);
    event TransactionSent(uint from, uint to, string currency, uint amount);

    mapping(uint => User) public usersMap;
    mapping(uint => Transaction) public transactionsMap;
    Transaction[] public allTransactions;

    // modifiers
    modifier notOverWriteUser(string memory _uName, string memory _uPass) {
        bytes memory userID = generateUserID(_uName, _uPass);
        require(checkIfUserIdExisits(userID) == false, "User Already Exists");
        _;
    }

    modifier checkEnoughAmountInCurrency(
        uint _senderId,
        string calldata _currency,
        uint _amount,
        uint _receiver
    ) {
        uint coinId = getCoinID(_currency);
        require(checkUserExistance(_receiver) == true, "User not Exists");
        require(usersMap[_senderId].userAmount[coinId] > 0, "Not enough coins");
        require(
            usersMap[_senderId].userAmount[coinId] > _amount,
            "Not enough coins"
        );
        _;
    }

    // echecking user existance by its incremental id
    function checkUserExistance(uint _userID) internal view returns (bool) {
        bool result;
        for (uint count = 0; count < totalUsers; count++) {
            if (
                keccak256(abi.encodePacked(usersMap[count].userID)) ==
                keccak256(abi.encodePacked(usersMap[_userID].userID))
            ) {
                result = true;
                break;
            } else {
                result = false;
            }
        }
        return result;
    }

    // Help functions
    function checkIfUserIdExisits(
        bytes memory _userID
    ) internal view returns (bool) {
        bool result;
        for (uint count = 0; count < totalUsers; count++) {
            if (
                keccak256(abi.encodePacked(usersMap[count].userID)) ==
                keccak256(abi.encodePacked(_userID))
            ) {
                result = true;
            } else {
                result = false;
            }
        }
        return result;
    }

    //
    function getAllTransactions() external view returns (Transaction[] memory) {
        return (allTransactions);
    }

    //
    function getUserModel(uint _tracer) external view returns (User memory) {
        return usersMap[_tracer];
    }

    //
    function generateUserID(
        string memory _uName,
        string memory _uPass
    ) internal pure returns (bytes memory) {
        return abi.encodePacked(_uName, _uPass);
    }

    //
    function getCoinID(string calldata _currency) internal pure returns (uint) {
        if (
            keccak256(abi.encodePacked(_currency)) ==
            keccak256(abi.encodePacked("btc"))
        ) {
            return 0;
        } else if (
            keccak256(abi.encodePacked(_currency)) ==
            keccak256(abi.encodePacked("eth"))
        ) {
            return 1;
        } else if (
            keccak256(abi.encodePacked(_currency)) ==
            keccak256(abi.encodePacked("ltc"))
        ) {
            return 2;
        } else if (
            keccak256(abi.encodePacked(_currency)) ==
            keccak256(abi.encodePacked("sol"))
        ) {
            return 3;
        } else if (
            keccak256(abi.encodePacked(_currency)) ==
            keccak256(abi.encodePacked("bnb"))
        ) {
            return 4;
        } else {
            revert("Wrong Coin Deposition Provided");
        }
    }

    function getAmounts(uint _id) external view returns (uint[5] memory) {
        return usersMap[_id].userAmount;
    }

    function getCurrencies(uint _id) external view returns (string[5] memory) {
        return usersMap[_id].userCurrencies;
    }

    function deposit(
        uint _id,
        uint _amount,
        string calldata _currency
    ) external {
        uint coinId = getCoinID(_currency);
        usersMap[_id].userAmount[coinId] += _amount;
        emit TransactionSent(1000, _id, _currency, _amount);
        transactionsMap[totalTransactions] = Transaction({
            senderID: 1000,
            receiverID: _id,
            amountTransfered: _amount,
            currencyTransfered: _currency,
            tType: "Deposit"
        });
        allTransactions.push(transactionsMap[totalTransactions]);
        totalTransactions++;
    }

    function signUp(
        string calldata _userName,
        string calldata _userBio,
        string calldata _userPass,
        string calldata _visa
    ) external notOverWriteUser(_userName, _userPass) {
        bytes memory userId = generateUserID(_userName, _userPass);
        User memory user;
        user = User({
            accountID: totalUsers,
            userAddress: msg.sender,
            userName: _userName,
            userBio: _userBio,
            userPass: _userPass,
            visaCard: _visa,
            // transaction:Transaction(1,2),
            userCurrencies: ["btc", "eth", "ltc", "sol", "bnb"],
            userAmount: [uint(0), uint(0), uint(0), uint(0), uint(0)],
            userID: userId
        });

        usersMap[totalUsers] = user;
        emit UserCreated(_userName, totalUsers);
        totalUsers++;
    }

    function login(
        uint _tracerID,
        string calldata _userName,
        string calldata _password
    ) external returns (User memory, bool) {
        if (
            (keccak256(abi.encodePacked(usersMap[_tracerID].userName)) ==
                keccak256(abi.encodePacked(_userName))) &&
            (keccak256(abi.encodePacked(usersMap[_tracerID].userPass)) ==
                keccak256(abi.encodePacked(_password)))
        ) {
            emit UserLogin("Successfully Login", _tracerID);
            return (usersMap[_tracerID], true);
        } else {
            // to make sure all data provided is right
            // using the bool value to complete login process in flutter
            emit UserLogin("Login Failed, No user found", _tracerID);

            return (usersMap[_tracerID], false);
        }
    }

    function transferFund(
        uint _senderId,
        uint _receiverId,
        uint _amount,
        string calldata _currency
    )
        external
        checkEnoughAmountInCurrency(_senderId, _currency, _amount, _senderId)
    {
        uint coinId = getCoinID(_currency);
        usersMap[_senderId].userAmount[coinId] -= _amount;
        usersMap[_receiverId].userAmount[coinId] += _amount;
        // creating a transaction
        emit TransactionSent(_senderId, _receiverId, _currency, _amount);
        transactionsMap[totalTransactions] = Transaction({
            senderID: _senderId,
            receiverID: _receiverId,
            amountTransfered: _amount,
            currencyTransfered: _currency,
            tType: "Transfer"
        });
        allTransactions.push(transactionsMap[totalTransactions]);
        totalTransactions++;
    }
}
// (keccak256(abi.encodePacked(usersMap[_tracerID].userName)) == keccak256(abi.encodePacked(_userName)) )
// && (keccak256(abi.encodePacked(usersMap[_tracerID].userPass)) == keccak256(abi.encodePacked(_password)) )
