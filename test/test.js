const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

describe("Twitter CRUD", function () {
  it("Add Tweet", async function () {
    const Tweet = await ethers.getContractFactory("Twitter");
    const hardhatTweet = await Tweet.deploy();

    await hardhatTweet.addTweet("Success Tweet");

    const tweets = await hardhatTweet.getAllTweets();
    const lastTweet = tweets[tweets.length - 1];

    const { content } = lastTweet;

    assert.equal(content, "Success Tweet");
  });

  it("Update Tweet", async function () {
    const Tweet = await ethers.getContractFactory("Twitter");
    const hardhatTweet = await Tweet.deploy();

    await hardhatTweet.addTweet("Success Tweet");
    await hardhatTweet.updateTweet(1, "Update Tweet Successfully");

    const tweets = await hardhatTweet.getAllTweets();

    assert.equal(tweets[0].content, "Update Tweet Successfully");
  });

  it("Update Tweet Fail with Tweet Not Found", async function () {
    const Tweet = await ethers.getContractFactory("Twitter");
    const hardhatTweet = await Tweet.deploy();

    await hardhatTweet.addTweet("Success Tweet");
    await hardhatTweet.addTweet("Success Tweet2");
    await hardhatTweet.deleteTweet(1);

    await expect(
      hardhatTweet.updateTweet(1, "Update Tweet Successfully"),
    ).to.be.revertedWith("Tweet Not Found");
  });

  it("Delete Tweet", async function () {
    const Tweet = await ethers.getContractFactory("Twitter");
    const hardhatTweet = await Tweet.deploy();

    await hardhatTweet.addTweet("Success Tweet");
    await hardhatTweet.addTweet("Success Tweet2");
    const oldTweets = await hardhatTweet.getAllTweets();
    await hardhatTweet.deleteTweet(1);

    const tweets = await hardhatTweet.getAllTweets();

    assert.equal(oldTweets.length - 1, tweets.length);
  });

  it("Delete Tweet Fail with Tweet Not Exist", async function () {
    const Tweet = await ethers.getContractFactory("Twitter");
    const hardhatTweet = await Tweet.deploy();

    await hardhatTweet.addTweet("Success Tweet");
    await hardhatTweet.deleteTweet(1);

    await expect(hardhatTweet.deleteTweet(1)).to.be.revertedWith(
      "Tweet Not Exist",
    );
  });
});
