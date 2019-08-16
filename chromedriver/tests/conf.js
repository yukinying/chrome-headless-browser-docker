exports.config = {
  seleniumAddress: 'http://chrome:4444/wd/hub',
  specs: ['spec.js'],
  capabilities: {
    browserName: 'chrome',
    chromeOptions: {
      args: [ "--headless", "--disable-gpu", "--window-size=800,600" ]
    }
  }
};

