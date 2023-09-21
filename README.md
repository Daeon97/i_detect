# efotainer

A prototype for a tracking and monitoring app for Efotainer, a solar-powered IoT enabled
cooling unit for storing and transporting perishables at a controlled temperature. The IoT
device monitors and sends certain parameters to AWS IoT Core using the MQTT protocol. A
[lambda function](https://github.com/Daeon97/iot-core-to-dynamo-db-function/tree/efotainer)
then listens on the specified topic and copies the data from AWS IoT Core to AWS Dynamo DB.
The idea is for the app to be able to show historical data, hence the data persistence to
Dynamo DB. Currently, the app uses the MQTT protocol to establish communication with AWS IoT
Core, listens on the specified topic and just displays these metrics to the user including the
current location of Efotainer on the map
