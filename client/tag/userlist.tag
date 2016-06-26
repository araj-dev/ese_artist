<userlist>
   <div id = userlist>
   <h3>Players List</h3>
   <div class="user">
    <li each={ users } >
        <span class="name">NAME : {name}</span>
        <span class="ready" if={ready}>準備完了</span>
    </li>
    </div>
   </div>
   <script>
       this.on('update',function(){
           this.users = opts.userslist;
           this.update();
       });
   </script>
   
   <style scoped>
       .ready {
           color:red;
           display:inline-block;
       }
       .user {
           width:400px;
           heigth:150px;
           padding:20px;
       }
       h3{
           font-size:14px;
           margin-bottom: 0;
       }
   </style>
</userlist>