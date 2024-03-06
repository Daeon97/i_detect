Efotainer is a prototype for a tracking and monitoring app for Efotainer, a solar-powered IoT enabled
cooling unit for storing and transporting perishables at a controlled temperature. The IoT
device monitors and sends certain parameters to AWS IoT Core using the MQTT protocol. A
[lambda function](https://github.com/Daeon97/iot-core-to-dynamo-db-function/tree/efotainer)
then listens on the specified topic and copies the data from AWS IoT Core to AWS Dynamo DB.
The app then pulls data from Dynamo DB and displays both historical data and current data including
the current location of the unit on a map. Communication between the app and Dynamo DB hapens over an
AppSync GraphQL API. The app itself is powered by an Amplify backend. The GraphQL schema can be found in
the [amplify/backend/api/efotainer/schema.graphql](https://github.com/Daeon97/i_detect/blob/efotainer/amplify/backend/api/efotainer/schema.graphql)
directory

# Screenshots
<img src="https://github.com/Daeon97/i_detect/assets/40745212/8dbc6233-9fc0-45df-a0e3-00648cdd9ecd" width="200" height="400" />
<img src="https://github.com/Daeon97/i_detect/assets/40745212/42951767-e7b3-4408-a9d9-5b5daeea556a" width="200" height="400" />

# Demo
[Screencast from 2024-03-06 17-13-06.webm](https://github.com/Daeon97/i_detect/assets/40745212/253161ed-ca5d-4d13-9b8c-fa4991c88f49)
