//
//  TeamFilterButtonView.swift
//  EmployeeDirectory
//
//  Created by Edward Arribasplata on 12/2/22.
//

import SwiftUI

struct TeamMenuView: View {
    @EnvironmentObject var vm: DirectoryViewModel
    
    @AppStorage("selectedTeam") var selectedTeam = "All Teams"
    
    var body: some View {
        Menu {
            Button { storeAllTeamsSelected() } label: { Text("All Teams") }
            ForEach(vm.teams, id: \.self) { team in
                Button { storeSpecificTeamSelected(team:team) } label: { Text(team) }
            }
        } label: {
            HStack(spacing:3){
                Text(selectedTeam).font(.title3)
                Image(systemName: "chevron.up.chevron.down").font(.subheadline)
            }
            .foregroundColor(.blue).fontWeight(.bold)
        }
        .transition(.opacity)
        .id(selectedTeam)
    }
    
    func storeAllTeamsSelected() {
        withAnimation{
            selectedTeam = "All Teams"
        }
    }
    
    func storeSpecificTeamSelected(team:String) {
        withAnimation{
            selectedTeam = team
        }
    }
}

struct TeamFilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TeamMenuView().environmentObject(DirectoryViewModel())
    }
}
