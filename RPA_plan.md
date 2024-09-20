 ### step-by-step breakdown outlining the RPA guy's work 😺 
 I had my way around this in web studio , but didn't turn out that good, but. it's possible 

### UiPath Workflow Steps for File Upload

#### 1. Open UiPath Studio
   - Launch UiPath Studio and create a new process or open an existing one.

#### 2. Add Required Packages
   - Go to **Manage Packages**.
   - Search for and install the **UiPath.WebAPI.Activities** package.

#### 3. Create Variables
   - In the **Variables** pane, create the following variables:
     - **filePath** (String): This will hold the path to the file you want to upload (e.g., `C:\path\to\your\file.txt`).
     - **uploadUrl** (String): This will hold the URL of the web server's upload endpoint (e.g., `http://your-web-server/upload`).

#### 4. Use Assign Activities
   - Drag and drop two **Assign** activities into the workflow.
   - For the first **Assign** activity:
     - **To**: `filePath`
     - **Value**: `"C:\path\to\your\file.txt"`
   - For the second **Assign** activity:
     - **To**: `uploadUrl`
     - **Value**: `"http://your-web-server/upload"`

#### 5. Add HTTP Request Activity
   - Drag and drop the **HTTP Request** activity into your workflow.
   - Configure the properties of the **HTTP Request** activity:
     - **Method**: Set this to `POST`.
     - **EndPoint**: Use the `uploadUrl` variable.
     - **Body**: Select `Form` as the type.
     - **Form Data**: Click on the "+" button to add a new field:
       - **Key**: Enter the expected field name (e.g., `"file"`).
       - **Value**: Set this to `filePath` to upload the file.

#### 6. Set Content Type
   - In the **Headers** section of the HTTP Request:
     - Add a new header:
       - **Name**: `Content-Type`
       - **Value**: `multipart/form-data`

#### 7. Handle the Response
   - After the **HTTP Request** activity, add a **Write Line** or **Log Message** activity to capture the server’s response.
     - Set the **Text** property to `response.Content` (where `response` is the variable that holds the output of the HTTP Request).

### Example Workflow Structure
Here’s how the workflow will look in sequence:

1. **Assign Activity**
   - **To**: `filePath`
   - **Value**: `"C:\path\to\your\file.txt"`

2. **Assign Activity**
   - **To**: `uploadUrl`
   - **Value**: `"http://your-web-server/upload"`

3. **HTTP Request Activity**
   - **Method**: `POST`
   - **EndPoint**: `uploadUrl`
   - **Body**: `Form`
     - **Form Data**:
       - **Key**: `"file"`
       - **Value**: `filePath`
   - **Headers**:
     - **Content-Type**: `multipart/form-data`

4. **Write Line / Log Message Activity**
   - **Text**: `response.Content`

### Final Steps
- Run the workflow to test the file upload.
- Make sure the server is set up to accept file uploads at the specified endpoint.
