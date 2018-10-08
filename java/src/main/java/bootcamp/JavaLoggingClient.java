package bazel.bootcamp;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.grpc.StatusRuntimeException;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

/** A simple client that sends messages to the server to be stored. */
public class JavaLoggingClient {
  private static final Logger logger = Logger.getLogger(JavaLoggingClient.class.getName());

  private final ManagedChannel channel;
  private final LoggerGrpc.LoggerBlockingStub blockingStub;

  /** Construct client connecting to server at {@code host:port}. */
  public JavaLoggingClient(String host, int port) {
    this(
        ManagedChannelBuilder.forAddress(host, port)
            // Disable TLS to avoid needing certificates.
            .usePlaintext()
            .build());
  }

  /** Construct client for accessing the Logging server using the existing channel. */
  JavaLoggingClient(ManagedChannel channel) {
    this.channel = channel;
    blockingStub = LoggerGrpc.newBlockingStub(channel);
  }

  public void shutdown() throws InterruptedException {
    channel.shutdown().awaitTermination(5, TimeUnit.SECONDS);
  }

  /** Send log message to the server. */
  public void sendLogMessageToServer(String message) {
    logger.info("Trying to send message '" + message + "' to server...");
    LogMessage logMessage = LogMessage.newBuilder().setMessage(message).build();
    try {
      blockingStub.sendLogMessage(logMessage);
    } catch (StatusRuntimeException e) {
      logger.log(Level.WARNING, "RPC failed: {0}", e.getStatus());
      return;
    }
  }

  public static void main(String[] args) throws Exception {
    JavaLoggingClient client = new JavaLoggingClient("localhost", 50051);
    System.out.println(
        "Enter log messages to send to the server, enter 'exit' to stop the client.");
    Scanner scanner = new Scanner(System.in);
    String message = scanner.nextLine();
    while (!message.equals("exit")) {
      client.sendLogMessageToServer(message);
      message = scanner.next();
    }
    client.shutdown();
  }
}
