
import mdap
import matplotlib.pyplot as plt

#plt.style.use("~/Apps/wedap/styles/default.mplstyle")
plt.style.use("~/github/wedap/styles/default.mplstyle")

open_2lao = [4.361296844482421875e+01, 7.470593189823416935e+01]
closed_1lst = [3.103689956665039062e+01, 5.269151791352962277e+01]

def wepr_plot(variant, ax=None, title=None):
    if ax is None:
        fig, ax = plt.subplots()
    if title is None:
        title = variant[5:]
    plot_options = {"xlim" : (30,90),
                    "ylim" : (27.5,50),
                    "xlabel" : "Opening Angle ($\degree$)",
                    "ylabel" : "Cu(II)-Cu(II) Distance ($\AA$)",
                    #"cmap" : "Blues",
                    "p_max" : 5,
                    "p_units" : "kcal",
                    "title" : title, 
                    "ax" : ax,
                    }
    pc = [f"{variant}/v{i:02d}/06_pcoord.dat" for i in range(1,6)]
    mdap.MD_Plot(Xname=pc, Xindex=1, Yname=pc, Yindex=0, data_type="pdist", **plot_options).plot()
    #pc = [f"{variant}/rep{i}.dat" for i in range(1,6)]
    #mdap.MD_Plot(Xname=pc, Xindex=0, Yname=pc, Yindex=2, data_type="pdist", **plot_options).plot()
    #pc = [f"{variant}/all_pcoord_{i}.dat" for i in range(1,6)]
    #mdap.MD_Plot(Xname=pc, Xindex=1, Yname=pc, Yindex=0, data_type="pdist", last_frame=20000, **plot_options).plot()
    # Mark reference points
    ax.plot(open_2lao[1], open_2lao[0], 'o', color="tab:orange", markersize=8, label="Open", markeredgecolor="black")
    ax.plot(closed_1lst[1], closed_1lst[0], 'o', color="white", markersize=8, label="Closed", markeredgecolor="black")
    #ax.legend(frameon=False, loc="upper right")
    #ax.grid(True)

# TODO: multi variant plot, and a time course plot for each replica

def plot_all_variants(variants=["1lst_WT", "1lst_T121A", "1lst_T121K", "1lst_Y14A", "1lst_T121A-Y14A"]):
    fig, axes = plt.subplots(2, 3, figsize=(10,6), sharex=True, sharey=True)
    for i, variant in enumerate(variants):
        plot_options = {"xlim" : (30,90),
                        "ylim" : (27.5,50),
                        "xlabel" : "Opening Angle ($\degree$)",
                        "ylabel" : "Cu(II)-Cu(II) Distance ($\AA$)",
                        #"cmap" : "Blues",
                        "p_max" : 5,
                        "p_units" : "kcal",
                        "title" : variant[5:], 
                        "ax" : axes.flat[i],
                        }
        pc = [f"{variant}/v{i:02d}/06_pcoord.dat" for i in range(1,6)]
        mdap.MD_Plot(Xname=pc, Xindex=1, Yname=pc, Yindex=0, data_type="pdist", **plot_options).plot()
        # Mark reference points
        axes.flat[i].plot(open_2lao[1], open_2lao[0], 'o', markersize=8, label="Open")
        axes.flat[i].plot(closed_1lst[1], closed_1lst[0], 'o', markersize=8, label="Closed")
        #axes.flat[i].legend()

def plot_timeseries(variant, replicas=5, ax=None):
    if ax is None:
        fig, ax = plt.subplots(1, 2, figsize=(10,3))

    for replica in range(1, replicas+1):
        pc = f"{variant}/v{replica:02d}/06_pcoord.dat"
        plot_options = {"xlabel" : "Time (ns)",
                        "title" : f"{variant[5:]}",
                        "plot_mode" : "line",
                        "timescale" : 10,
                        }
        mdap.MD_Plot(Xname=pc, Xindex=0, Xinterval=10, data_type="time", ylim=(27.5, 50),
                     ax=ax[0], ylabel="Cu(II)-Cu(II) Distance ($\AA$)", **plot_options).plot()
        mdap.MD_Plot(Xname=pc, Xindex=1, Xinterval=10, data_type="time", ylim=(30, 90),
                     ax=ax[1], ylabel="Opening Angle ($\degree$)", **plot_options).plot()

if __name__ == "__main__":
    variants = ["1lst_WT", "1lst_Y14A", "1lst_T121A-Y14A"]
    variants = ["noliz"]
    variants = ["1lst_WT", "1lst_T121A", "1lst_T121K", "1lst_Y14A", "1lst_T121A-Y14A"]
    # for variant in variants:
    #     wepr_plot(variant)
    #     plt.savefig(f"06_pdist_{variant}.pdf")
    ##plt.savefig(f"all_pdist_{variant}.pdf")

    # wepr_plot("1lst_WT")
    # plt.savefig(f"marker_legend.pdf")
    # plt.show()

    # plot_all_variants()
    # #plt.savefig(f"all_variants_pdist.pdf")
    # plt.show()
    #variants = ["1lst_WT", "1lst_T121A", "1lst_Y14A"]
    for variant in variants:
        plot_timeseries(variant)
        plt.savefig(f"timeseries_{variant}.pdf")
