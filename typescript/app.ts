import {LogMessage} from '../proto/logger/logger_ts_proto'

class ServerLogs {
  getServerLogs(): Promise<Array<LogMessage>> {
    return fetch('http://localhost:8081')
        .then((response) => this.checkStatus(response))
        .then(
            (response) => this.parseJSON(response)
                              .then(
                                  (response) => {return Promise.resolve(
                                      this.displayServerLogs(response))})
                              .catch((error) => this.throwError(error)));
  }

  private checkStatus(response: Response): Promise<Response> {
    console.log('in check status');
    if (response.status >= 200 && response.status < 300) {
      return Promise.resolve(response);
    } else {
      let error = new Error(response.statusText);
      throw error;
    }
  }

  private parseJSON(response: Response): Promise<Response> {
    console.log('in parse json');
    return response.json();
  }

  private displayServerLogs(data: Response) {
    console.log('in display');
    const el: HTMLDivElement = document.createElement('div');
    el.innerText = JSON.stringify(data);
    const message: LogMessage = LogMessage.fromObject(data);
    console.log(message);
    el.className = 'ts1';
    document.body.appendChild(el);
    return undefined;
  }

  private throwError(error) {
    document.write('<p>Oops! something wrong! We are so embarrased..</p>');
    console.log(error);
    return Promise.reject(error);
  }
}

let serverLogs = new ServerLogs();
let button = document.createElement('button');
button.textContent = 'Get Server Logs';
button.onclick =
    function() {
  serverLogs.getServerLogs();
}

    document.body.appendChild(button);
