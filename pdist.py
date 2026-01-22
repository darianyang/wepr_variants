
import mdap
import matplotlib.pyplot as plt

plt.style.use("~/Apps/wedap/styles/default.mplstyle")

#variant = "1lst_T121K"
variant = "noliz"

def wepr_plot():
    plot_options = {"xlim" : (30,90),
                    "ylim" : (25,55),
                    "xlabel" : "Opening Angle ($\degree$)",
                    "ylabel" : "Cu(II)-Cu(II) Distance ($\AA$)",
                    #"cmap" : "Blues",
                    "p_max" : 5,
                    "p_units" : "kcal",
                    "title" : variant, 
                    }
    #pc = [f"{variant}/v{i:02d}/06_pcoord.dat" for i in range(1,6)]
    pc = [f"{variant}/rep{i}.dat" for i in range(1,6)]
    mdap.MD_Plot(Xname=pc, Xindex=1, Yname=pc, Yindex=0, data_type="pdist", **plot_options).plot()

wepr_plot()
#plt.savefig(f"06_pdist_{variant}.pdf")
plt.savefig(f"pdist_{variant}.pdf")
#plt.show()
