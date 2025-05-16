$PlayniteApi.Database.BeginBufferUpdate()
try {
    # Alle Spiele abrufen und nach Name sortieren
    $games = $PlayniteApi.Database.Games | Sort-Object {$_.Name -replace '^\d{1,4} - ', ''}

    $counter = 1
    foreach ($game in $games) {
        # Neue Nummerierung erstellen mit 4-stelligem Präfix
        $newName = "{0:D4} - {1}" -f $counter, ($game.Name -replace '^\d{1,4} - ', '')
        
        # Name aktualisieren, wenn die Nummerierung nicht korrekt ist
        if ($game.Name -ne $newName) {
            $game.Name = $newName
            $PlayniteApi.Database.Games.Update($game)
            Write-Output "Updated: $newName"
        }
        $counter++
    }
} finally {
    $PlayniteApi.Database.EndBufferUpdate()
}
Write-Output "Numbering fixed. Please sort by name in Playnite."


