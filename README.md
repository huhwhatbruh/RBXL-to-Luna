# RBXL-to-Lune
Roblox - Lune / Rojo compatible, easily transfer RBLX to a VScode format that is easily interperated idek 


just create a source file in the root directory with a filetree like ./src and then inside of it have ./client ./server ./shared, make sure to have rokit installed and lune installed, then put the RBXL file into the root directory and run the script using "lune run extract_scripts.luau" and it'll work, this took me hours of banging my head on my desk to make so like i hope it helps somebody.


it should look like               NAME OF ROOT FOLDER 
                                    |       |      |
                           lune_scripts    src    rokit.toml
                               |            |
    extract_scripts / inspect_apis.luau    client / server / shared
                     
