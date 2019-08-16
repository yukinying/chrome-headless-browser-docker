describe('angularjs homepage todo list', function() {
  it('should add a todo', function() {
    browser.waitForAngularEnabled(false);
    browser.get('http://info.cern.ch/hypertext/WWW/TheProject.html');
    var title = browser.getTitle();
    expect(title).toEqual('The World Wide Web project');
  });
});

