usePlugin("@nomiclabs/buidler-waffle");

module.exports = {
  solc: {
    version: "0.6.8",
    optimizer: {
      enabled: true,
      runs: 999999
    }
  }
};
