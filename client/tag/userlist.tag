<userlist>
   <div id = userlist>
    <li each = {users} >
        <p>NAME : {name}</p>
    </li>
   </div>
   <script>
    this.users = opts.users; 
   </script>
</userlist>