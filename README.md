# ImageCombination
Combining two images to a single one using a mask. Matlab self project


Δημιουργεί μία νέα εικόνα από δύο άλλες, συνδυάζοντάς τες, σύμφωνα με τη μάσκα που δίνεται. Οι δύο εικόνες πρέπει να ονομάζονται foto1a.jpg και foto2a.jpg αντίστοιχα. Καλό είναι η ανάλυσή τους να είναι ήδη 513χ513. Ωστόσο, αν δεν είναι γίνεται η μετατροπή τους από το πρόγραμμα. 
Η μάσκα έχει την ίδια ανάλυση και μπορεί να είναι οποιοσδήποτε συνδυασμός άσπρου-μαύρου. Όπου η μάσκα είναι άσπρη, παίρνει τα εικονοστοιχεία της foto1a.jpg, ενώ αντίστοιχα στις μαύρες περιοχές από τα foto2a.jpg. Υπάρχει ένα αρχείο σαν παράδειγμα μάσκας (mask.jpg).
Για την ομαλή μετατροπή χρησιμοποιούνται πυραμίδες Gause και Laplace. 

Creates a new image from two other, combining them according to the given mask. The two images should be named foto1a.jpg and foto2a.jpg respectively. Their analysis should be already 513x513. However, if they are not, they are converted from the program.
The mask has the same resolution and can be any combination of black and white. Where the mask is white, it gets the pixels of photo1a.jpg, while in the black areas of foto2a.jpg. A mask example is given (mask.jpg).
For smooth conversion, Gause and Laplace pyramids are used.
