export default class RconConsole {
  constructor() {
    this.serverId = document.querySelector('[data-server]').dataset.server;
    this.commandInput = document.querySelector(
      '[data-behavior="command-input"]'
    );
    this.commandSend = document.querySelector('[data-behavior="command-send"]');
    this.rconResponse = document.querySelector(
      '[data-behavior="rcon-response"]'
    );

    this.fetchLogsBtn = document.querySelector('[data-behavior="fetch-logs"]');

    this.handleCommandSend = this.handleCommandSend.bind(this);
    this.handleFetchLogs = this.handleFetchLogs.bind(this);
  }

  init() {
    this.bindEventListeners();
  }

  bindEventListeners() {
    this.commandSend.addEventListener('click', this.handleCommandSend);
    this.fetchLogsBtn.addEventListener('click', this.handleFetchLogs);
  }

  handleFetchLogs() {
    App.server.fetch_logs();
  }

  handleCommandSend() {
    if (!this.commandInput.value) {
      return;
    }
    const commandSent = this.buildCommandSentDiv(this.commandInput.value);
    // Send command to ActionCable
    App.server.send_command(this.commandInput.value);

    // Append the command and then reset it.
    this.rconResponse.appendChild(commandSent);
    this.commandInput.value = '';
  }

  buildCommandSentDiv(msg) {
    const commandSent = document.createElement('div');
    commandSent.appendChild(document.createTextNode('You sent: ' + msg));
    return commandSent;
  }
}
