# Generate opaque white Web icons from the original, unchanged brand artwork.
Add-Type -AssemblyName System.Drawing

$projectRoot = Split-Path -Parent $PSScriptRoot
$sourcePath = Join-Path $projectRoot 'assets\brand\haya-logo-original.png'
$source = [System.Drawing.Bitmap]::new($sourcePath)
$sourceRect = [System.Drawing.Rectangle]::new(430, 130, 690, 585)

try {
    $outputs = @(
        @{ Path = 'web\favicon.png'; Size = 64; Padding = 0.11 },
        @{ Path = 'web\icons\Icon-192.png'; Size = 192; Padding = 0.16 },
        @{ Path = 'web\icons\Icon-512.png'; Size = 512; Padding = 0.16 },
        @{ Path = 'web\icons\Icon-maskable-192.png'; Size = 192; Padding = 0.16 },
        @{ Path = 'web\icons\Icon-maskable-512.png'; Size = 512; Padding = 0.16 }
    )

    foreach ($output in $outputs) {
        $size = [int]$output.Size
        $padding = [double]$output.Padding
        $usable = $size * (1 - 2 * $padding)
        $scale = [Math]::Min($usable / $sourceRect.Width, $usable / $sourceRect.Height)
        $width = [int][Math]::Round($sourceRect.Width * $scale)
        $height = [int][Math]::Round($sourceRect.Height * $scale)
        $x = [int][Math]::Round(($size - $width) / 2)
        $y = [int][Math]::Round(($size - $height) / 2)
        $targetRect = [System.Drawing.Rectangle]::new($x, $y, $width, $height)
        $bitmap = [System.Drawing.Bitmap]::new($size, $size)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        try {
            $graphics.Clear([System.Drawing.Color]::White)
            $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
            $graphics.DrawImage($source, $targetRect, $sourceRect, [System.Drawing.GraphicsUnit]::Pixel)
            $targetPath = Join-Path $projectRoot $output.Path
            $bitmap.Save($targetPath, [System.Drawing.Imaging.ImageFormat]::Png)
        } finally {
            $graphics.Dispose()
            $bitmap.Dispose()
        }
    }
} finally {
    $source.Dispose()
}
