Dyanmic server to support byte ranges for variation workflows


To test 
</br>

(copy .env.example to .env and update token information in .env)
</br>
<code>cp .env.example  .env</code>

The test uses public workspaces in appdev or ci
So set the following variables for ci or appdev in .env file
</br>
KBASE_ENDPOINT=https://appdev.kbase.us/services
</br>
token=************

</br>
<code>docker-compose up --build</code>
</br>
In the browser go to
</br>
<code>http://localhost:5000/ws/aratiny/countHits?keyword=dormancy </code>
</br>


