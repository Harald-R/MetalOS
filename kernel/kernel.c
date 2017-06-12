#include "../drivers/screen.h"
#include "../drivers/ioports.h"

// The main kernel function
void kmain()
{
	screen = (unsigned short *) VGA_MEM_LOC;
	attrib = VGA_COLOR_WHITE;

	clear_screen();

    puts("MetalOS\n\n");

    puts("Lorem ipsum dolor sit amet, veri adipiscing te vix, eu quem verear nec. Laoreet eligendi qualisque usu ad, quo ne etiam euismod repudiandae. Sale voluptaria expetendis id sit, dicta bonorum inimicus nec ex. Vim feugiat apeirian id, te pri mucius denique neglegentur, has sale perpetua conclusionemque te. Tibique urbanitas accommodare ius ei. Vim hinc recusabo prodesset id.\n\nId honestatis philosophia sit, usu vitae pertinax et. Sit accusam maiestatis id, saepe labitur per ad.Corpora patrioque repudiandae vis eu. Esse intellegam mel an. Tritani deleniti lucilius eum ne, ne qui debet mentitum. Ad his dicam noluisse pericula.\n\n");
	
    puts("Meanwhile, you can print single characters: ");
    putc('a');

	while(1);
}
