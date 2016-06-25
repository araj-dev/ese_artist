<userlist>
  <h1>GAME</h1>
   <div id = userlist>
    <li each={ users } >
       <p>{id}</p>
        <p>NAME : {name}</p>
        <div class="ready" if={ready}>準備完了</div>
    </li>
   </div>
   <script>
       this.on('update',function(){
           this.users = opts.userslist;
           this.update();
       });
   </script>
   
   <style scoped>
       .ready{
           color:red;
           display:inline-block;
       }
   </style>
</userlist>