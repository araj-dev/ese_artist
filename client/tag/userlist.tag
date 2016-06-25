<userlist>
  <h1>GAME</h1>
   <div id = userlist>
    <li each={ users } >
       <p>{id}</p>
        <span class="name">NAME : {name}</span>
        <span class="ready" if={ready}>準備完了</span>
    </li>
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
   </style>
</userlist>