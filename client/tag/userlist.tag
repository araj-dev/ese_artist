<userlist>
  <h1>GAME</h1>
   <div id = userlist>
    <li each={ users } >
       <p>{id}</p>
        <p>NAME : {name}</p>
        <div if={ready}>準備完了</div>
    </li>
   </div>
   <script>
       this.users = opts.userslist;
       console.log(opts);
   </script>
</userlist>