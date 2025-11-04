# 📁 File Size Analyzer

A comprehensive file and folder analysis tool that helps you understand disk usage, identify large files, and optimize storage space. Available in both desktop (Tkinter) and web (Streamlit) versions.

## 🚀 Features

### Core Analysis
- **Folder Size Analysis**: Scan and analyze folder contents recursively
- **File Type Categorization**: Automatically categorize files by type (Documents, Images, Videos, Audio, Archives, Code)
- **Size Filtering**: Filter files by size range (GB/MB/KB)
- **Date Filtering**: Filter files by creation/modification date
- **Search Functionality**: Search files by name or extension
- **Drag & Drop Support**: Easily drop folders for analysis

### Export Options
- **Excel Export**: Detailed reports with multiple worksheets
- **PDF Export**: Professional reports with charts and statistics
- **HTML Export**: Interactive web reports with visualizations

### Visualization
- **Interactive Charts**: Pie charts, bar graphs, and trend analysis
- **File Type Distribution**: Visual breakdown of file categories
- **Size Distribution**: Histograms and size analysis charts
- **Optimization Suggestions**: Compression recommendations with space savings

### Optimization Features
- **Compression Analysis**: Calculate potential space savings
- **File Optimization Suggestions**: Recommendations for different file types
- **Storage Optimization Report**: Detailed optimization strategies

## 📋 Requirements

### Python Dependencies
```
pandas>=1.5.0
openpyxl>=3.0.0
fpdf>=1.7.2
matplotlib>=3.5.0
seaborn>=0.11.0
numpy>=1.21.0
tkinterdnd2>=0.3.0
pyinstaller>=5.0.0
streamlit>=1.28.0
plotly>=5.15.0
```

## 🛠️ Installation

### Option 1: Windows Executable (Recommended)
Download the latest release from GitHub:
1. Go to [Releases](https://github.com/yourusername/noob-folder-analyzer/releases)
2. Download `FileSizeAnalyzer-v1.0.0-Windows.zip`
3. Extract and run `FileSizeAnalyzer.exe`
4. No installation required - portable application

### Option 2: Docker (Web Version)

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd noob-folder-analyzer
   ```

2. **Start with Docker**:
   ```bash
   # Smart Docker (Recommended - Auto-detects available drives)
   start_docker_smart.bat
   .\start_docker_smart.ps1
   
   # Manual Docker
   start_docker.bat
   .\start_docker.ps1
   docker-compose up --build
   ```

3. **Open in browser**:
   ```
   http://localhost:8501
   ```

### Option 3: Local Installation (Development)

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd noob-folder-analyzer
   ```

2. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

## 🎯 Usage

### Windows Executable (Recommended)
Simply run `FileSizeAnalyzer.exe` - no installation required!

### Desktop Application (Tkinter - Development)

Run the desktop version with a graphical user interface:

```bash
python main.py
```

**Features**:
- Modern dark theme UI
- Drag & drop folder selection
- Real-time filtering and search
- Export to Excel, PDF, and HTML
- Interactive charts and visualizations

### Web Application (Streamlit)

Run the web version for browser-based access:

```bash
streamlit run streamlit_app.py
```

**Features**:
- Web-based interface accessible from any browser
- Interactive Plotly charts
- File upload and folder selection
- Export functionality
- Responsive design

## 🐳 Docker Setup

### Windows Sürücü Erişimi
Docker container'da Windows sürücülerinize erişmek için:

- **C: sürücüsü**: `/host/c/Users/YourName/Documents`
- **D: sürücüsü**: `/host/d/YourFolder`
- **E: sürücüsü**: `/host/e/YourFolder`

### Örnek Kullanım
```
Windows Path: C:\Users\YourName\Documents
Docker Path: /host/c/Users/YourName/Documents
```

### Sorun Giderme
- Docker Desktop'ın çalıştığından emin olun
- Windows sürücülerinizin erişilebilir olduğunu kontrol edin
- Detaylı bilgi için `DOCKER_README.md` dosyasını inceleyin

## 📖 How to Use

### 1. Select a Folder
- **Desktop**: Click "Select Folder" or drag & drop a folder
- **Web**: Use the folder input or upload files
- **Docker**: Use Docker path format (e.g., `/host/c/Users/YourName/Documents`)

### 2. Apply Filters (Optional)
- **File Type Filter**: Select specific file categories
- **Size Filter**: Set minimum and maximum file sizes
- **Date Filter**: Filter by file creation/modification dates
- **Search Filter**: Search for specific file names or extensions

### 3. Analyze Results
- View file statistics and breakdowns
- Explore interactive charts and visualizations
- Review optimization suggestions

### 4. Export Reports
- **Excel**: Detailed spreadsheet with multiple worksheets
- **PDF**: Professional report with charts and analysis
- **HTML**: Interactive web report

## 📊 File Categories

The tool automatically categorizes files into the following types:

- **Documents**: PDF, DOC, DOCX, TXT, RTF, ODT
- **Images**: JPG, JPEG, PNG, GIF, BMP, TIFF, SVG
- **Videos**: MP4, AVI, MKV, MOV, WMV, FLV, WEBM
- **Audio**: MP3, WAV, FLAC, AAC, OGG, WMA
- **Archives**: ZIP, RAR, 7Z, TAR, GZ, BZ2
- **Code**: PY, JS, HTML, CSS, JAVA, CPP, C, PHP

## 🔧 Optimization Features

### Compression Analysis
The tool provides optimization suggestions for different file types:

- **Images**: JPEG quality reduction, WebP conversion, PNG optimization
- **Videos**: H.264/H.265 compression, AV1 codec, WebM conversion
- **Documents**: PDF compression, ZIP/7-Zip archiving
- **Audio**: MP3/AAC compression, OGG Vorbis conversion
- **Archives**: 7-Zip LZMA2, ZIP deflate, RAR5 compression
- **Code**: Minification, Gzip/Brotli compression

### Space Savings Calculation
- Estimates potential space savings for each optimization method
- Provides percentage-based compression ratios
- Calculates total potential savings across all files

## 📁 Export Formats

### Excel Export
- **Summary Sheet**: Overview of folder analysis
- **File Details**: Complete file listing with metadata
- **Category Analysis**: Breakdown by file type
- **Size Distribution**: Size range analysis
- **Optimization Report**: Compression suggestions and savings

### PDF Export
- **Professional Layout**: Clean, formatted report
- **Charts and Graphs**: Visual representations of data
- **Optimization Recommendations**: Detailed suggestions
- **File Statistics**: Comprehensive file information

### HTML Export
- **Interactive Charts**: Plotly-based visualizations
- **Responsive Design**: Works on desktop and mobile
- **Exportable Data**: Download data in various formats
- **Modern UI**: Clean, professional appearance

## 🐳 Docker Support

The Streamlit version includes Docker support for cross-platform compatibility:

```bash
# Build Docker image
docker build -t file-size-analyzer .

# Run container
docker run -p 8501:8501 file-size-analyzer
```

## 🔍 Advanced Features

### Filtering Options
- **Multi-category Selection**: Select multiple file types
- **Size Presets**: Quick size range selection (Small, Medium, Large)
- **Date Presets**: Recent files (Today, Week, Month, Year)
- **Custom Ranges**: Set custom size and date ranges

### Search Capabilities
- **File Name Search**: Search by exact or partial file names
- **Extension Search**: Filter by specific file extensions
- **Case Insensitive**: Search works regardless of case
- **Real-time Results**: Instant search results as you type

### Performance Optimization
- **Efficient Scanning**: Optimized folder traversal
- **Memory Management**: Handles large folders efficiently
- **Progress Tracking**: Real-time progress updates
- **Error Handling**: Graceful handling of permission errors

## 🚨 Troubleshooting

### Common Issues

1. **Permission Errors**
   - Ensure you have read access to the selected folder
   - Run as administrator if needed (Windows)

2. **Missing Dependencies**
   - Install all requirements: `pip install -r requirements.txt`
   - Update pip: `python -m pip install --upgrade pip`

3. **Large Folder Analysis**
   - For very large folders, analysis may take time
   - Use filters to reduce analysis scope
   - Consider running during off-peak hours

4. **Export Issues**
   - Ensure sufficient disk space for exports
   - Close any open Excel files before exporting
   - Check file permissions in export directory

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request
