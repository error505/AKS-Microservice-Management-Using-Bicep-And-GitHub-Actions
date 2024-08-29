import os
import azure.functions as func
import datetime
import json
import logging
from azure.servicebus import ServiceBusClient, ServiceBusMessage

# Azure Function app initialization
app = func.FunctionApp()

# Azure Service Bus Connection Settings
CONNECTION_STR = os.getenv('SERVICE_BUS_CONNECTION_STRING')
QUEUE_NAME = os.getenv('SERVICE_BUS_QUEUE_NAME')

@app.service_bus_queue_trigger(arg_name="azservicebus", queue_name="importmessages",
                               connection="nothingNow") 
def send_message_to_service_bus():
    """
    Function to send a message to the Azure Service Bus queue.
    """
    try:
        # Create a ServiceBusClient
        servicebus_client = ServiceBusClient.from_connection_string(conn_str=CONNECTION_STR, logging_enable=True)
        
        with servicebus_client:
            # Get a Queue Sender object
            sender = servicebus_client.get_queue_sender(queue_name=QUEUE_NAME)
            with sender:
                # Send a message
                message = ServiceBusMessage("Hello from the sender function!")
                sender.send_messages(message)
                logging.info("Message sent to Azure Service Bus queue!")
    except Exception as e:
        logging.error(f"Error sending message to Service Bus: {e}")

