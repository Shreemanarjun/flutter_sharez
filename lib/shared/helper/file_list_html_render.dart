import 'package:file_picker/file_picker.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter_sharez/data/model/server_info.dart';

String htmlFiles(
    {required List<PlatformFile> files, required ServerInfo serverInfo}) {
  String allfilesUi = "";
  const styles = """\$hoverColor: #bada55;

html {
   font-size: 15px;
}

body {
 ///  background: #c4c4c4;
  //// font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol";
}

/* Style buttons */
.btn {
  background-color: DodgerBlue;
  border: none;
  color: white;

  cursor: pointer;
  font-size: 18px;
}

/* Darker background on mouse-over */
.btn:hover {
  background-color: RoyalBlue;
}

button {
    border: none;
    text-decoration: none;
    color: inherit;
    font-family: inherit;
    font-size: inherit;
    cursor: pointer;
    -webkit-appearance: none;
    -moz-appearance: none;
   box-sizing: content-box;
}

.row {
   display: flex;
   width: 100%;
   margin-bottom: 0.375rem;
   
   &:hover .cell,
   &:focus-within .cell,
   &:active .cell {
      background: rgba(\$hoverColor, 0.7);
      border-color: lighten(\$hoverColor, 20);
   }
}

.cell {
   background: #fff;
   padding: 0.75rem 1rem;
   height: 2.5rem;
   cursor: pointer;
   transition: background-color 96ms ease, box-shadow 48ms ease, outline 48ms ease;
   box-shadow: 0 0 0 1px rgba(255,255,255,0.3) inset;
   outline: 1px solid rgba(255,255,255,0.001);
   
   &:hover,
   &:focus,
   &:focus-within {
      transition: 48ms ease;
      box-shadow: 0 0 0 1px #fff inset;
      outline: 1px solid #fff;
   }
   
   &.-file {
      flex: 1;
      display: flex;
      position: relative;
      
      > i {
         font-size: 2rem;
          vertical-align: middle;
          line-height: 2.5rem;
         margin-right: 0.75rem;
      }
      
      a {
         text-decoration: none;
         color: #222;
         font-weight: bold;
         
         &::after {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            display: block;
            content: '';
         }
      }
   }
   
   &.-action {
      display: block;
       margin-left: 0.1875rem;
       width: 4.5rem;
       font-size: 0.65rem;
       color: #586069;
       text-transform: uppercase;
       text-align: center;
       padding: 0.75rem 0;
      
      .label {
         transition: opacity 96ms ease;
         transition-delay: 24ms;
      }
      
      &:not(:hover):not(:focus) {
         .label {
            opacity: 0;
            transition: opacity 48ms ease;
            transition-delay: 0;
         }
         
         i {
            transform: translateY(0.25em);
            transition: transform 96ms ease;
         }
      }
      
      i {
         font-size: 1.75rem;
         line-height: 2rem;
         color: #000;
         display: block;
         transition: 48ms ease;
      }
   }
}

.inner {
    border-left: 1px solid #999;
    padding-left: 0.75rem;
}

.details {
   margin: 0.375rem 0;
   display: block;
}

.detail {
   margin-right: 0.75em;
   color: #586069;
   font-size: 0.8rem;
   
   i {
      font-size: inherit;
       line-height: inherit;
       margin-right: 0.1em;
   }
}



.-dropzone {
   border: 0.1835rem dashed #888;
    box-sizing: border-box;
    border-radius: 0.375rem;
    padding: 2px;
    justify-content: center;
    align-items: center;
   cursor: pointer;
   height: 5rem;
   
   i {
       margin: 1rem;
       font-size: 1.5rem;
       color: #999;
       text-shadow: 1px 1px 0 #ccc;
   }
   
   &:hover i,
   &:not(:hover) .drop-info {
      display: none;
   }
   
   &:hover {
      border-color: #555;
   }
}

.drop-info {
   font-size: 0.8rem;
   text-align: center;
   color: #555;
   
   strong {
      font-size: 1.375rem;
      color: #333;
      position: relative;
      
      &::before,
      &::after {
         display: block;
          width: 3rem;
          height: 2px;
          background: #555;
          content: "";
          position: absolute;
          top: 50%;
      }

      &::before {
          right: 100%;
          margin-right: 0.375rem;
      }

      &::after {
          left: 100%;
          margin-left: 0.375rem;
      }
   }
   
}""";

  for (var file in files) {
    final singlefileUi = """

<div class="row">
   
   <div class="cell -file">
      <i class="fa fa-file-text" aria-hidden="true"></i>
      <div class="inner">
         <a href="/files/${Uri.encodeFull(file.name)}" class="filename">${file.name}</a>
         <small class="details">
            <span class="detail -filesize"><i class="fa fa-hdd-o" aria-hidden="true"></i> ${FileSize.getSize(file.size)}</span>
         </small>
      </div>
         <div>&nbsp &nbsp &nbsp</div>
  <button class="btn"  type="submit" onclick="window.open('/files/${Uri.encodeFull(file.name)}')">
  
  <i class="fa fa-download" >
  
  </i> 
  
  
  Download
  
  </button>
   </div>

  
   
</div>

""";
    allfilesUi += " $singlefileUi";
  }
  return """
  <!DOCTYPE html>
      <html>
        <head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <style>
$styles
</style>
        <body>

     <h1> 
      Shared Files
     </h1>

     <h2>
Server Info

<h5>
<div>IP: ${serverInfo.ip}   </div>
<div>Port: ${serverInfo.port}   </div>
<div>OS: ${serverInfo.os}   </div>
<div>Version: ${serverInfo.version}   </div>
<div>Host: ${serverInfo.host}   </div>
</h5>


     </h2>
          $allfilesUi
      </body>
    </html>
    """;
}
