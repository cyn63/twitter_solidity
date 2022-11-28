pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Twitter {
  struct Tweet {
    address author;
    uint256 id;
    string content;
    uint256 timestamp;
  }

  Tweet[] public tweets;
  uint256 public tweetId = 1;

  mapping(address => string) tweetToUser;

  function addTweet(string memory _content) public {
    Tweet memory _tweet = Tweet({
      author: msg.sender,
      id: tweetId,
      content: _content,
      timestamp: block.timestamp
    });
    tweets.push(_tweet);
    tweetId++;
  }

  function getAllTweets() public view returns (Tweet[] memory) {
    return tweets;
  }

  function updateTweet(uint256 _tweetId, string memory _content) public {
    uint256 flag = 0;
    for (uint256 i = 0; i < tweets.length; i++) {
      if (tweets[i].id == _tweetId) {
        require(msg.sender == tweets[i].author, "Permission Denied");
        tweets[i].content = _content;
        flag = 1;
        break;
      }
    }
    require(flag == 1, "Tweet Not Found");
  }

  function deleteTweet(uint256 _tweetId) public {
    uint256 originSize = tweets.length;

    require(originSize > 0, "Tweet Not Exist");

    for (uint256 i = 0; i < tweets.length; i++) {
      if (tweets[i].id == _tweetId) {
        require(msg.sender == tweets[i].author, "Permission Denied");
        for (uint256 j = i; j < tweets.length - 1; j++) {
          tweets[j] = tweets[j + 1];
        }
        tweets.pop();
        break;
      }
    }
    require(originSize - 1 == tweets.length, "Tweet Not Exist");
  }
}
