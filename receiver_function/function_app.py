import os
import azure.functions as func
import logging
from azure.servicebus import ServiceBusClient, ServiceBusMessage

# Azure Function app initialization
app = func.FunctionApp()

# Azure Service Bus Connection Settings
CONNECTION_STR = os.getenv('SERVICE_BUS_CONNECTION_STRING')
QUEUE_NAME = os.getenv('SERVICE_BUS_QUEUE_NAME')

def send_message_to_service_bus(message_text: str):
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
                message = ServiceBusMessage(message_text)
                sender.send_messages(message)
                logging.info(f"Message sent to Azure Service Bus queue: {message_text}")
    except Exception as e:
        logging.error(f"Error sending message to Service Bus: {e}")

@app.function_name(name="SendServiceBusMessage")
@app.route(route="send-message", methods=["POST"])
def send_message(req: func.HttpRequest) -> func.HttpResponse:
    """
    HTTP-triggered function that sends a message to the Azure Service Bus.
    """
    try:
        # Parse the JSON request body
        req_body = req.get_json()
        message_text = req_body.get('message')

        if not message_text:
            return func.HttpResponse("Message text is required in the request body.", status_code=400)
        
        # Send the message to the Azure Service Bus queue
        send_message_to_service_bus(message_text)

        return func.HttpResponse(f"Message '{message_text}' sent to Service Bus queue.", status_code=200)
    
    except ValueError as e:
        logging.error(f"Invalid request body: {e}")
        return func.HttpResponse("Invalid JSON in the request body.", status_code=400)
    except Exception as e:
        logging.error(f"Unexpected error: {e}")
        return func.HttpResponse("An error occurred while processing the request.", status_code=500)
