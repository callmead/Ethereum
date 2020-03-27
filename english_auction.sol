pragma solidity ^0.5.7;

interface IERC20Token {
    function balanceOf(address owner) external returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function decimals() external returns (uint256);
}

contract EnglishAuction {
    address seller;

    IERC20Token public token;
    uint256 public reservePrice;
    uint256 public minIncrement;
    uint256 public timeoutPeriod;

    uint256 public auctionEnd;

    constructor(
        IERC20Token _token,
        uint256 _reservePrice,
        uint256 _minIncrement,
        uint256 _timeoutPeriod
    )
        public
    {
        token = _token;
        reservePrice = _reservePrice;
        minIncrement = _minIncrement;
        timeoutPeriod = _timeoutPeriod;

        seller = msg.sender;
        auctionEnd = now + timeoutPeriod;
    }

    address highBidder;

    mapping(address => uint256) public balanceOf;

    function withdraw() public {
        require(msg.sender != highBidder);

        uint256 amount = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        msg.sender.transfer(amount);
    }

    event Bid(address highBidder, uint256 highBid);

    function bid(uint256 amount) public payable {
        require(now < auctionEnd);
        require(amount >= reservePrice);
        require(amount >= balanceOf[highBidder]+minIncrement);

        balanceOf[msg.sender] += msg.value;
        require(balanceOf[msg.sender] == amount);

        highBidder = msg.sender;

        auctionEnd = now + timeoutPeriod;

        emit Bid(highBidder, amount);
    }

    function resolve() public {
        require(now >= auctionEnd);

        uint256 t = token.balanceOf(address(this));
        if (highBidder == address(0)) {
            require(token.transfer(seller, t));
        } else {
            // transfer tokens to high bidder
            require(token.transfer(highBidder, t));

            // transfer ether balance to seller
            balanceOf[seller] += balanceOf[highBidder];
            balanceOf[highBidder] = 0;

            highBidder = address(0);
        }
    }
}