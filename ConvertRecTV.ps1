#Path to ffmpeg
$ffmpegpath = "C:\ffmpeg\bin\ffmpeg.exe"
$ffmpeg_hw_enable = "nvidia" #NVIDIA GPU = 'nvidia', AMD= 'amd', Intel= 'intel', No hw accel. = '$false'



# Prompt the user to select the input directory using a graphical dialog
$folderBrowser = New-Object -ComObject Shell.Application
$selectedFolder = $folderBrowser.BrowseForFolder(0, "Select the input directory", 0)

if ($selectedFolder -ne $null) {
    # Get the selected input directory path
    $inputDir = $selectedFolder.Self.Path

    # Output directory where the converted files will be saved
    $outputDir = Join-Path -Path $inputDir -ChildPath "converted"

    # Create the output directory if it doesn't exist
    New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

    # Function to convert a TS file to H.265 (HEVC) in MKV format
    function ConvertToH265-MKV ($tsFile) {
        $filename = [System.IO.Path]::GetFileNameWithoutExtension($tsFile.Name)
        $inputFile = $tsFile.FullName
        $relativePath = $tsFile.FullName.Substring($inputDir.Length + 1)
        $outputFile = Join-Path -Path $outputDir -ChildPath ($relativePath -replace '\.ts$', '.mp4')
    
        # Create the directory structure if it doesn't exist
        $outputDirectory = [System.IO.Path]::GetDirectoryName($outputFile)
        if (-not (Test-Path -Path $outputDirectory)) {
            New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null
        }
               
        $ffmpegArgs = @(
            "-i `"$inputFile`"",
            "-c:v hevc_nvenc",
            "-c:a aac",
            "-strict experimental",
            "`"$outputFile`""
        )

        # Convert the .ts file to H.265 (HEVC) in MKV format using ffmpeg
        Write-Host "Converting: $($tsFile.FullName)"

        Start-Process -Wait -NoNewWindow -FilePath $ffmpegpath -ArgumentList $ffmpegArgs
        
    }

    # Recursively search for .ts files in the selected input directory and its subfolders
    $tsFiles = Get-ChildItem -Path $inputDir -Filter *.ts -File -Recurse

    if ($tsFiles.Count -gt 0) {
        Write-Host "Converting .ts files to H.265 (HEVC) in MKV format..."

        # Loop through each .ts file and convert it to H.265 (HEVC) in MKV format
        foreach ($tsFile in $tsFiles) {
            ConvertToH265-MKV $tsFile
        }

        Write-Host "Conversion complete."
    } else {
        Write-Host "No .ts files found in the selected directory and its subfolders."
    }
} else {
    Write-Host "No input directory selected."
}
