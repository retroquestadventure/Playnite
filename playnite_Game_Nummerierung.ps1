$PlayniteApi.Database.BeginBufferUpdate()
try {
    $counter = 1
    foreach ($game in $PlayniteApi.Database.Games) {
        $newName = "{0:D4} - {1}" -f $counter, $game.Name
        if ($game.Name -ne $newName) {
            $game.Name = $newName
            $PlayniteApi.Database.Games.Update($game)
        }
        $counter++
    }
} finally {
    $PlayniteApi.Database.EndBufferUpdate()
}

