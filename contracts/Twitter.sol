pragma solidity ^0.8.0;

import "hardhat/console.sol";

/// @title Twitter CRUD
/// @author Yuna CHO
/// @notice You can use this contract to add, read, update, delete tweets.
contract Twitter {
  /// @dev Contains information about the tweet
  struct Tweet {
    address author;
    uint256 id;
    string content;
    uint256 timestamp;
  }
  /// @dev Tweet struct array
  Tweet[] public tweets;
  /// @dev Tweet ID
  uint256 public tweetId = 1;

  mapping(address => string) tweetToUser;

  /// @notice Add tweets
  /// @param _content The content of user's tweet
  /// @dev Add information from user and tweet to the array.
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

  /// @notice Get all the tweets
  /// @return Returns all saved tweets
  function getAllTweets() public view returns (Tweet[] memory) {
    return tweets;
  }

  /// @notice Update tweets
  /// @param _tweetId The id of the tweet that user wants to update
  /// @param _content The content of the tweet that user wants to update
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

  /// @notice Delete tweets
  /// @param _tweetId The id of the tweet that user wants to delete
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
