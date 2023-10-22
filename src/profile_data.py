""" Create Pandas Profile using CSV Files as input"""

from ydata_profiling import ProfileReport
import pathlib
import pandas as pd
from typing import Literal


def create_profiles(
    stage: Literal["raw", "final"], data_dir=pathlib.Path, data_profile_dir=pathlib.Path
):
    """Create Pandas Profiles"""

    allowed_values = ["raw", "final"]
    if stage not in allowed_values:
        raise ValueError(
            f"'{stage}' is an unallowed value. Allowed values are: {allowed_values}"
        )

    file_paths = list(data_dir.rglob("*.csv"))

    for fp in file_paths:
        try:
            df = pd.read_csv(fp)
            profile = ProfileReport(df, title=fp.stem)
            fp_out = data_profile_dir / f"{fp.stem}_profile.html"
            profile.to_file(fp_out)
        except Exception as e:
            print(f"Exception occured: \n{e}")


def main(stage="raw"):
    data_dir = pathlib.Path.cwd().parent / "data" / stage
    data_profile_dir = pathlib.Path.cwd().parent / "data_profiles" / stage
    create_profiles("raw", data_dir, data_profile_dir)


if __name__ == "__main__":
    main()
