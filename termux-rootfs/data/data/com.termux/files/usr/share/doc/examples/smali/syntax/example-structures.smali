.class public Lcom/lohan/crackme1/example;
.super Ljava/lang/Object;
.source "example.java"
 
 
# static fields
.field private static Counter:I
 
 
# direct methods
# all the constructor does is set Counter to 0x10 (or 16)
.method public constructor <init>()V
    .registers 2
 
    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
 
    const/16 v0, 0x10
    sput v0, Lcom/lohan/crackme1/example;->Counter:I
 
    return-void
.end method
 
.method public static ArrayExample()V
    .registers 4
 
    .prologue
    const/4 v3, 0x1
    const/4 v2, 0x0
 
    .line 50
    const/4 v1, 0x5
 
    new-array v0, v1, [Ljava/lang/String;
 
    .line 52
    .local v0, someArray:[Ljava/lang/String;
 
    # put value v1 inside array v0 at index v2 (0x0)
    const-string v1, "set value at index 0"
    aput-object v1, v0, v2
 
    .line 53
    # put value v1 inside array v0 at index v3 (0x1)
    const-string v1, "index 1 has this value"
    aput-object v1, v0, v3
 
    .line 55
    # store in v1 the value from array v0 at index v2
    aget-object v1, v0, v2
 
    # store in v2 the value from array v0 at index v3
    aget-object v2, v0, v3
 
    # compare two strings
    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
 
    # if equals() returns 0, it means they are not equal, so just return
    if-eqz v1, :cond_1e
 
    .line 57
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;
    const-string v2, "array at index 0 = 1 (wont happen)"
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
 
    .line 59
    :cond_1e
    return-void
.end method
 
# loop from 0 to Counter
# just a few lines in java
.method public static LoopExample()V
    .registers 4
 
    .prologue
    .line 15
    const/4 v0, 0x0
 
    .local v0, i:I
    :goto_1
    sget v1, Lcom/lohan/crackme1/example;->Counter:I
 
    if-lt v0, v1, :cond_6
 
    .line 17
    return-void
 
    .line 16
    :cond_6
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;
 
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "current val for loop: "
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v2
 
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
 
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
 
    .line 15
    add-int/lit8 v0, v0, 0x1
 
    goto :goto_1
.end method
 
.method public static SwitchExample()V
    .registers 3
 
    .prologue
    .line 21
    const/16 v0, 0x2a
 
    .line 22
    .local v0, val:I
     
    # begin the switch
    # look down at .sparse_switch directive
    sparse-switch v0, :sswitch_data_2e
 
    # switch default just passes through to here
    .line 27
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;
    const-string v2, "invalid value"
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
 
    .line 29
    :goto_c
    return-void
 
    .line 23
    :sswitch_d # if v0 is 1, we'll be here
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;
    const-string v2, "val 1"
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    goto :goto_c
 
    .line 24
    :sswitch_15 # if v0 is 2
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;
    const-string v2, "val 2"
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    goto :goto_c
 
    .line 25
    :sswitch_1d # if v0 is 42
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;
    const-string v2, "val 42"
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    goto :goto_c
 
    .line 26
    :sswitch_25 # if v0 is 5
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;
    const-string v2, "val 5"
    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    goto :goto_c
 
    .line 22
    nop
 
    :sswitch_data_2e
    # if v0 is 0x1 goto :sswitch_d
    # if 0x2 :sswitch_15
    # and so on...
    .sparse-switch
        0x1 -> :sswitch_d   # 1
        0x2 -> :sswitch_15  # 2
        0x5 -> :sswitch_25  # 5
        0x2a -> :sswitch_1d # 42
    .end sparse-switch
.end method
 
.method public static TryCatchExample()V
    .registers 8
 
    .prologue
    const-string v7, ": "
 
    .line 33
    const-string v3, "google.com"
 
    .line 36
    .local v3, urlStr:Ljava/lang/String;
    # begin try here
    :try_start_4
    new-instance v2, Ljava/net/URL;
 
    invoke-direct {v2, v3}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
 
    .line 37
    .local v2, url:Ljava/net/URL;
    invoke-virtual {v2}, Ljava/net/URL;->openStream()Ljava/io/InputStream;
 
    move-result-object v1
 
    .line 38
    .local v1, is:Ljava/io/InputStream;
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_10
    # end of the try
     
     # if there was a MalformedURLException, goto :catch_11
    .catch Ljava/net/MalformedURLException; {:try_start_4 .. :try_end_10} :catch_11
     
    # IOException goes to :catch_36
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_10} :catch_36
 
    # if NO exception, just pass through:
    .line 46
    .end local v1           #is:Ljava/io/InputStream;
    .end local v2           #url:Ljava/net/URL;
    :goto_10
    return-void
 
    .line 39
    :catch_11
    # move the exception to v4, then to v0
    # all of the code below is what happens with an exception
    move-exception v4
    move-object v0, v4
 
    .line 41
    .local v0, e:Ljava/net/MalformedURLException;
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;
 
    new-instance v5, Ljava/lang/StringBuilder;
    const-string v6, "Invalid URL "
    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
 
    const-string v6, ": "
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
 
    invoke-virtual {v0}, Ljava/net/MalformedURLException;->getMessage()Ljava/lang/String;
    move-result-object v6
 
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
 
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
 
    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
 
    goto :goto_10
 
    .line 42
    .end local v0           #e:Ljava/net/MalformedURLException;
    # end exception code
     
    # begin exception code    
    :catch_36
    move-exception v4
    move-object v0, v4
 
    .line 44
    .local v0, e:Ljava/io/IOException;
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;
 
    new-instance v5, Ljava/lang/StringBuilder;
    const-string v6, "Unable to execute "
    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
 
    const-string v6, ": "
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
 
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;
    move-result-object v6
 
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
 
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
 
    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
 
    goto :goto_10
    # end exception code
.end method
