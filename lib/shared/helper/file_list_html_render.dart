import 'package:file_picker/file_picker.dart';
import 'package:flutter_sharez/data/model/server_info.dart';

String htmlFiles(
    {required List<PlatformFile> files, required ServerInfo serverInfo}) {
  return """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sharez - Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-glow: rgba(99, 102, 241, 0.4);
            --bg: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --text-main: #f8fafc;
            --text-dim: #94a3b8;
            --border: rgba(255, 255, 255, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        body {
            background-color: var(--bg);
            background-image: 
                radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.15) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(168, 85, 247, 0.15) 0px, transparent 50%);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding: 2rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3rem;
            animation: fadeInDown 0.8s ease-out;
        }

        .logo {
            font-size: 2rem;
            font-weight: 700;
            background: linear-gradient(135deg, #818cf8, #c084fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .server-badge {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            padding: 0.5rem 1.25rem;
            border-radius: 99px;
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            color: var(--text-dim);
        }

        .status-dot {
            width: 8px;
            height: 8px;
            background: #22c55e;
            border-radius: 50%;
            box-shadow: 0 0 10px #22c55e;
            animation: pulse 2s infinite;
        }

        .main-grid {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 2rem;
        }

        @media (max-width: 850px) {
            .main-grid { grid-template-columns: 1fr; }
            header { flex-direction: column; gap: 1.5rem; text-align: center; }
            body { padding: 1rem; }
        }

        .sidebar {
            animation: fadeInLeft 0.8s ease-out;
        }

        .card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 1.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .card-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1.25rem;
            color: var(--text-main);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
        }

        .info-label { color: var(--text-dim); }
        .info-value { color: var(--text-main); font-weight: 500; }

        .file-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            animation: fadeInUp 0.8s ease-out;
        }

        .file-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .file-card:hover {
            transform: translateY(-8px);
            border-color: var(--primary);
            box-shadow: 0 20px 40px -10px var(--primary-glow);
        }

        .file-preview-thumb {
            width: 100%;
            height: 160px;
            background: rgba(15, 23, 42, 0.5);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        .file-preview-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .file-preview-thumb .icon-overlay {
            font-size: 3rem;
            color: var(--primary);
            opacity: 0.5;
        }

        .file-info {
            flex: 1;
        }

        .file-name {
            font-size: 1.05rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
            word-break: break-all;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .file-meta {
            font-size: 0.85rem;
            color: var(--text-dim);
        }

        .actions {
            display: flex;
            gap: 0.75rem;
            margin-top: auto;
        }

        .action-btn {
            flex: 1;
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-main);
            padding: 0.75rem;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
            transition: all 0.2s;
            border: 1px solid var(--border);
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .action-btn.primary {
            background: var(--primary);
            border: none;
        }

        .action-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--primary);
        }

        .action-btn.primary:hover {
            background: #4f46e5;
            box-shadow: 0 4px 12px var(--primary-glow);
            transform: translateY(-2px);
        }

        /* Preview Modal */
        #preview-modal {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.9);
            backdrop-filter: blur(12px);
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .modal-content {
            width: 100%;
            max-width: 1100px;
            height: 90vh;
            background: #000;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 0 100px rgba(0,0,0,0.8);
            position: relative;
            display: flex;
            flex-direction: column;
        }

        .modal-header {
            padding: 1.25rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #1e293b;
            border-bottom: 1px solid var(--border);
        }

        .preview-body {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #000;
            overflow: hidden;
        }

        #video-player, #image-preview, #pdf-preview {
            max-width: 100%;
            max-height: 100%;
            display: none;
        }
        
        #pdf-preview {
            width: 100%;
            height: 100%;
            border: none;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInLeft {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }
        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(34, 197, 94, 0); }
            100% { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="logo">
                <i class="fa-solid fa-cloud-arrow-up"></i>
                Sharez
            </div>
            <div class="server-badge">
                <div class="status-dot"></div>
                ${serverInfo.deviceName} is sharing
            </div>
        </header>

        <div class="main-grid">
            <aside class="sidebar">
                <div class="card">
                    <div class="card-title">
                        <i class="fa-solid fa-circle-info"></i>
                        Device Info
                    </div>
                    <div class="info-row">
                        <span class="info-label">Address</span>
                        <span class="info-value">${serverInfo.ip}:${serverInfo.port}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">OS</span>
                        <span class="info-value">${serverInfo.os}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Hostname</span>
                        <span class="info-value">${serverInfo.host}</span>
                    </div>
                </div>

                <div class="card" style="margin-top: 1.5rem; background: linear-gradient(135deg, rgba(99, 102, 241, 0.1), rgba(168, 85, 247, 0.1)); border-color: var(--primary);">
                    <p style="font-size: 0.85rem; color: var(--text-dim); line-height: 1.5;">
                        <i class="fa-solid fa-bolt" style="color: #fbbf24; margin-right: 0.5rem;"></i>
                        Secure peer-to-peer sharing enabled. Files are served directly from the device.
                    </p>
                </div>
            </aside>

            <main class="file-grid" id="file-container">
                <!-- Skeleton loader -->
                <div class="file-card shimmer" style="height: 300px;"></div>
                <div class="file-card shimmer" style="height: 300px; opacity: 0.5;"></div>
                <div class="file-card shimmer" style="height: 300px; opacity: 0.3;"></div>
            </main>
        </div>
    </div>

    <!-- Preview Modal -->
    <div id="preview-modal" onclick="closePreview(event)">
        <div class="modal-content" onclick="event.stopPropagation()">
            <div class="modal-header">
                <h3 id="preview-title" style="font-size: 1.1rem; color: #fff;">File Name</h3>
                <button onclick="closePreview()" style="background:none; border:none; color:#fff; cursor:pointer; font-size:1.5rem; transition: opacity 0.2s;" onmouseover="this.style.opacity=0.7" onmouseout="this.style.opacity=1">
                    <i class="fa-solid fa-circle-xmark"></i>
                </button>
            </div>
            <div class="preview-body">
                <video id="video-player" controls preload="auto" playsinline>
                    Your browser does not support the video tag.
                </video>
                <img id="image-preview" src="" alt="Preview">
                <iframe id="pdf-preview" src=""></iframe>
            </div>
        </div>
    </div>

    <script>
        const fileContainer = document.getElementById('file-container');
        const modal = document.getElementById('preview-modal');
        const videoPlayer = document.getElementById('video-player');
        const imagePreview = document.getElementById('image-preview');
        const pdfPreview = document.getElementById('pdf-preview');
        const previewTitle = document.getElementById('preview-title');
        
        function formatBytes(bytes, decimals = 2) {
            if (!+bytes) return '0 Bytes';
            const k = 1024;
            const dm = decimals < 0 ? 0 : decimals;
            const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return `\${parseFloat((bytes / Math.pow(k, i)).toFixed(dm))} \${sizes[i]}`;
        }

        function getFileType(filename) {
            const ext = filename.split('.').pop().toLowerCase();
            if (['mp4', 'mkv', 'mov', 'webm', 'avi'].includes(ext)) return 'video';
            if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'svg'].includes(ext)) return 'image';
            if (['pdf'].includes(ext)) return 'pdf';
            return 'other';
        }

        function getFileIcon(filename) {
            const ext = filename.split('.').pop().toLowerCase();
            const icons = {
                pdf: 'fa-file-pdf',
                jpg: 'fa-file-image',
                jpeg: 'fa-file-image',
                png: 'fa-file-image',
                webp: 'fa-file-image',
                mp4: 'fa-file-video',
                mkv: 'fa-file-video',
                mov: 'fa-file-video',
                mp3: 'fa-file-audio',
                zip: 'fa-file-zipper',
                rar: 'fa-file-zipper',
                txt: 'fa-file-lines'
            };
            return icons[ext] || 'fa-file';
        }

        async function updateFileList() {
            try {
                const response = await fetch('/filepath');
                const data = await response.json();
                renderFiles(data.paths);
            } catch (error) {
                console.error('Failed to fetch files:', error);
            }
        }

        function openPreview(link, name) {
            const type = getFileType(name);
            previewTitle.innerText = name;
            modal.style.display = 'flex';
            
            // Hide all
            videoPlayer.style.display = 'none';
            imagePreview.style.display = 'none';
            pdfPreview.style.display = 'none';
            
            if (type === 'video') {
                videoPlayer.src = link;
                videoPlayer.style.display = 'block';
                videoPlayer.play();
            } else if (type === 'image') {
                imagePreview.src = link;
                imagePreview.style.display = 'block';
            } else if (type === 'pdf') {
                pdfPreview.src = `https://docs.google.com/viewer?url=\${encodeURIComponent(link)}&embedded=true`;
                // Fallback direct for local
                if (link.includes('127.0.0.1') || link.includes('localhost') || link.startsWith('http://192') || link.startsWith('http://10.')) {
                    pdfPreview.src = link;
                }
                pdfPreview.style.display = 'block';
            }
        }

        function closePreview(event) {
            modal.style.display = 'none';
            videoPlayer.pause();
            videoPlayer.src = "";
            imagePreview.src = "";
            pdfPreview.src = "";
        }

        function renderFiles(files) {
            if (files.length === 0) {
                fileContainer.innerHTML = `
                    <div style="grid-column: 1/-1; text-align: center; padding: 4rem 2rem;">
                        <i class="fa-solid fa-folder-open" style="font-size: 4rem; color: var(--text-dim); opacity: 0.3;"></i>
                        <h3 style="margin-top: 1.5rem; font-size: 1.5rem;">Nothing shared yet</h3>
                        <p style="color: var(--text-dim); margin-top: 0.5rem;">Waiting for the host to add files...</p>
                    </div>
                `;
                return;
            }

            fileContainer.innerHTML = files.map(item => {
                const type = getFileType(item.file.name);
                const canPreview = type !== 'other';
                
                let previewThumb = '';
                if (type === 'image') {
                    previewThumb = `<img src="\${item.link}" loading="lazy">`;
                } else {
                    previewThumb = `<i class="fa-solid \${getFileIcon(item.file.name)} icon-overlay"></i>`;
                }

                return `
                    <div class="file-card">
                        <div class="file-preview-thumb">
                            \${previewThumb}
                        </div>
                        <div class="file-info">
                            <div class="file-name" title="\${item.file.name}">\${item.file.name}</div>
                            <div class="file-meta">\${formatBytes(item.file.size)} • \${item.file.fileExt.toUpperCase() || 'FILE'}</div>
                        </div>
                        <div class="actions">
                            \${canPreview ? `
                            <button onclick="openPreview('\${item.link}', '\${item.file.name}')" class="action-btn" title="Stream/View">
                                <i class="fa-solid fa-eye"></i>
                                View
                            </button>
                            ` : ''}
                            <a href="\${item.link}" download="\${item.file.name}" class="action-btn primary">
                                <i class="fa-solid fa-download"></i>
                                Download
                            </a>
                        </div>
                    </div>
                `;
            }).join('');
        }

        // WebSocket for real-time updates
        function connectWS() {
            const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
            const ws = new WebSocket(`\${protocol}//\${window.location.host}/ws`);

            ws.onmessage = (event) => {
                const data = JSON.parse(event.data);
                if (data.type === 'update') updateFileList();
            };

            ws.onclose = () => setTimeout(connectWS, 3000);
            ws.onopen = () => updateFileList();
        }

        connectWS();
    </script>
</body>
</html>
""";
}
